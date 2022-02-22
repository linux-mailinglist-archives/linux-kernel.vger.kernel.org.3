Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723B4C0516
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiBVXIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBVXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:08:21 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4C8BF1C;
        Tue, 22 Feb 2022 15:07:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 539063201ECF;
        Tue, 22 Feb 2022 18:07:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 22 Feb 2022 18:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=REt9l10PYX2xZE9ln
        yPPgeY5X7bPaOgLYZ0HVoEzyuQ=; b=WPmVfYgZM4weF/NmmXVaOdC6SS7ALfywf
        SpX54kiexstX4iGLrAJrL/EiKsomWLjDsHuOu/6DiGXHZmNJHSf8GHQKiJbKFtTC
        VGKWmvz1Ap9LemoCnFsN9uHcs5cFs301XAAhsSDHO0iBile7O1ILjEJZc/We2eD6
        UM1pnUXefZ02GmwgzzD6FdLpCEStrfLzp1/AigmVNCF+2miXfTKupZvQq+To0AWr
        I9/UHGflVev0kUqUygaopNGAPoSs+JMUkAB3WlfphXELOYDkNc905VOMLiewZu0/
        LffMrx89h9tRM5zzX3rU+8xuUtQ3muunbjCQQ94CKjKdPtK02vdRg==
X-ME-Sender: <xms:x2wVYqcVhofPy8wS_QIjVPIiT-sDx7bfx1bsZLs7jcKgkWFajRshvw>
    <xme:x2wVYkNedTtomgfijSZLAKy8ufbFc0bFYUX5y2AtKcUyVJV5J3JlqUYeg5FixBAn2
    KbRgxi58OriaXedUdo>
X-ME-Received: <xmr:x2wVYriszbplnFu0UenkfI-mGcByqUUw9i2WD3o8F6_v59wqhJMWBuzLcwi3mHoRGMH7OJ8BozwUBEp6DCWPc3j7y0MJcOIzlGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:x2wVYn9GQ2GJSC_Z1K-EpB_lrkS8W0iTy5J8wa5zrT7nuM0SKhciuw>
    <xmx:x2wVYmviUjZ20LRPuZPO2nyfN0V8GrlYznynY0v9kztKRdZaeNOPqg>
    <xmx:x2wVYuElQZ7sTQ3JuvbmLppZ_ZXHz0xd9wp7gj2u7eubIMgwlNeYUA>
    <xmx:x2wVYqIGGvsdN0W0syQElVOzoJ8tdCp5ULb7wazyu9m7zrNUB7aDYw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 18:07:49 -0500 (EST)
Date:   Wed, 23 Feb 2022 10:08:08 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christoph Hellwig <hch@infradead.org>
cc:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha152x: Clean up struct scsi_pointer usage
In-Reply-To: <YhSYDC4YMEx0XCYY@infradead.org>
Message-ID: <62241a-be3-ed61-965f-afec1452f2c4@linux-m68k.org>
References: <4e17ff7295a96e31ed21ccb250c65b56c173b530.1645484982.git.fthain@linux-m68k.org> <YhSYDC4YMEx0XCYY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, 22 Feb 2022, Christoph Hellwig wrote:

> On Tue, Feb 22, 2022 at 10:09:42AM +1100, Finn Thain wrote:
> > Bring aha152x into line with 10 other drivers which assign
> > scsi_host_template.cmd_size = sizeof(struct scsi_pointer)
> > and avoid the "struct foo { struct bar; };" silliness.
> > 
> > Remove a pointless scsi_pointer->have_data_in assignment.
> 
> I think this going in the wrong direction.  The scsi_pointer should go 
> away entirelym and the fields actually used by the driver should move 
> into the aha152x_cmd_priv structure instead.
> 
> Same for all other drivers still using the scsi_pointer.
> 

This patch is addressing an inconsistency in the patches already accepted 
into 5.18/scsi-staging in Martin's repo.

A number of Bart's patches had the same effect as the patch you're 
objecting to here. Hence,

$ git grep "cmd_size.*scsi_pointer"
drivers/scsi/a2091.c:               .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/a3000.c:	            .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/fdomain.c:             .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/gvp11.c:	            .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/imm.c:                 .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/mvme147.c:             .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/pcmcia/nsp_cs.c:       .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/pcmcia/sym53c500_cs.c: .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/ppa.c:                 .cmd_size = sizeof(struct scsi_pointer),
drivers/scsi/sgiwd93.c:             .cmd_size = sizeof(struct scsi_pointer),

Since that series was very popular with reviewers, and being that this 
patch is just more of the same, I have no idea as to how to proceed.

Are you asking me to rework Bart's series? Or are you asking Martin to 
drop it, or both, or neither...
