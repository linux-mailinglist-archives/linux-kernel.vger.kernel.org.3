Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4E4E5E36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiCXFkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347174AbiCXFkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:40:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299392DFF;
        Wed, 23 Mar 2022 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lb6i7tpT7cjB88JTys3ca4IMlk97xBviyr0SJNTk9xY=; b=IalXUPclMnMDmoV/oz4Ylgh+qH
        nc+Wy5p6Vqgx8knKMNurMQpBSixeupIp2DcF3/ly4hLEQvJURiP2PRjU5k2E+Q0huEmexvKYqyvTP
        z/859vB6GhK5f5MYnzRku3XPNFuJvAoxEf6dYUM9ObKhpT+toOa5aQSWQsP9hhhvc0LqUpSBiOPH7
        u0xSvfauw/N+pMvFdsRkTjSgDwPui323hSChxpGeKEUxky+bGa35ZiAyZQsn1WFchaw0cSLRP6vzv
        e11iytJ+CBfyaBWUckc0ShkcQ3N0zpSr8ops6jSp9RczQUR0MKtjXKY/WfvGg+hoF7zZWc3eV/1fg
        /RQWCJcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXGAs-00FeUL-Lv; Thu, 24 Mar 2022 05:38:18 +0000
Date:   Wed, 23 Mar 2022 22:38:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha152x: Stop using struct scsi_pointer
Message-ID: <YjwDylpop9OSMlIW@infradead.org>
References: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:29:37AM +1100, Finn Thain wrote:
> Remove aha152x_cmd_priv.scsi_pointer by moving the necessary members
> into aha152x_cmd_priv proper.
> 
> Tested with an Adaptec SlimSCSI APA-1460A card.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

This looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>
