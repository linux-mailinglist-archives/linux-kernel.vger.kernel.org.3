Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6865C4BBA58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiBRN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:57:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiBRN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:56:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED025D6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:56:36 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nL3kM-0007k1-Hu; Fri, 18 Feb 2022 14:56:30 +0100
Date:   Fri, 18 Feb 2022 14:56:30 +0100
From:   Martin Kaiser <lists@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] staging: r8188eu: comment about the chip's packet
 format
Message-ID: <20220218135630.hodcdxnvcavk54jn@viti.kaiser.cx>
References: <20220218092252.853807-1-martin@kaiser.cx>
 <20220218102227.GE2407@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218102227.GE2407@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Fri, Feb 18, 2022 at 10:22:53AM +0100, Martin Kaiser wrote:

> > Would it make sense to add a word of warning to prevent others from
> > repeating this exercise?

> Just the fact that these structs are endian means they're from the
> firmware or the network.

> If a struct has a pointer in it, then it's rarely part of the UAPI but
> if it has endian data then it probably is.

ah, these are useful criteria, thanks. I see that the comment isn't
really necessary...
