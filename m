Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73A554318
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351433AbiFVGs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350787AbiFVGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019E35AAB;
        Tue, 21 Jun 2022 23:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C61D614E6;
        Wed, 22 Jun 2022 06:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E55C34114;
        Wed, 22 Jun 2022 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655880523;
        bh=zM0SW3vqNvu0Oc6om+TTIoJUvS2PT8GEnviSnb9hLno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmQzKyb3CG2gPCAVJkj+/LikY9zwkW/roOS6Db+Gf/QOqKsegmYt85n7+SdefA31H
         OA90DiFFcTRC8MPwNm/G/bhIPujlIXjzBK/3jeZqYd8ckmg8BTLhRalTVMBB8WE37G
         WT1Dojj2sBqWI1BUEd9ltg/tbiGenB7NSv9xJD98=
Date:   Wed, 22 Jun 2022 08:48:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Wang <peter.wang@mediatek.com>
Cc:     matthias.bgg@gmail.com, len.brown@intel.com, pavel@ucw.cz,
        rafael@kernel.org, stanley.chu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, powen.kao@mediatek.com,
        qilin.tan@mediatek.com, lin.gui@mediatek.com,
        tun-yu.yu@mediatek.com
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before
 release supplier
Message-ID: <YrK7Q7yFUIHRoKLS@kroah.com>
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <a6ed562c-5ec0-231d-0eee-a35f2ba7a344@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ed562c-5ec0-231d-0eee-a35f2ba7a344@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Wed, Jun 22, 2022 at 02:09:16PM +0800, Peter Wang wrote:
> Hi all,
> 
> 
> gentle ping for this bug fix review.

It's only been 1 week, please give us a chance.  To help out, always
feel free to review other patch submissions.

thanks,

greg k-h
