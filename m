Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FE578E14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiGRXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiGRXKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:10:35 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E53335C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:10:33 -0700 (PDT)
Received: from [212.54.57.107] (helo=csmtp3.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1oDZsm-0003qX-EA
        for linux-kernel@vger.kernel.org; Tue, 19 Jul 2022 01:10:32 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id DZsmoPXBO45FHDZsmoyjeI; Tue, 19 Jul 2022 01:10:32 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=e64V9Il/ c=1 sm=1 tr=0 ts=62d5e868 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=RgO8CyIxsXoA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8
 a=VT__EnHI_Uz2LLgsLvQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1658185832;
        bh=1TyKuhPIhlN5MF99QaiJXin9ajfIBhPaPtXfRcnrSsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CqnGiWwepS8FcNiI3SlYT7OuGD/MriiGlLYYdHHCarlHHxkQ0FhM/Zgsh9BzLJIid
         JFge2MajGW2tTsI8A9HbWNsCVaGitAAM3rRL32Ivs65k010xglucaE15eC2SdxI+8K
         dODstW/14NSW91IoDBrursapVykZxJgRl+AO7PIce4gv4fZyEN2jTT/anjl3r+R9v3
         6SY39+nGtdLUbdv5er1phNjaAnGdbw+oPUdo2MvytrgHLl1P6pfaxgLyOz9cS6Euih
         fEtnATi7p/Rm3u68f9e7h50WVLDAugNs/gU2QEbU1XQ2F9otRyy2FSEO9tfS+AbKrx
         n+wHyVr38KA1g==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 0E1658DB5C; Tue, 19 Jul 2022 00:10:32 +0100 (BST)
Date:   Tue, 19 Jul 2022 00:10:32 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Retbleed, Zen2 and STIBP
Message-ID: <YtXoaPqzkP7jc2M+@llamedos.localdomain>
References: <YtUXda9ymAI0ED7n@llamedos.localdomain>
 <63cbe83c-aed7-48ae-978b-bb85c211b28a@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <63cbe83c-aed7-48ae-978b-bb85c211b28a@citrix.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-CMAE-Envelope: MS4xfOCnZ8C0V5op9M6anFs6XLcRJDMKV3Afs8yW7zlG92lJTX3HdscV474OtnkKdpwOiTTbJ6nEaqeZUMMDtvy4amzKftzPHw1eGy8EglzW994cebTJi6LC
 3fbsj5aa7TW8uwekbCC4QxQtJFUFQjES6CQ5uMvCSekbQRSxy2UJ/nP49RQ5RBzBihc4x3+J4IlayNNVisyrRCnepRCVDPRL1UC/oLaWP6AA9HsjG53QqdHR
 vz9ESb7jULgVJV8LGBBWgA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:47:15PM +0000, Andrew Cooper wrote:
> On 18/07/2022 09:19, Ken Moffat wrote:
> > Probably like most people, I find the detail of the available
> > retbleed mitigations obscure.  In particular, for zen2 the options
> > *might* include ibpb or unret.
> 
> That's because retbleed is two totally different bugs between Intel and
> AMD, and on AMD, it's only a subcase.
> 
> In this case for AMD, the root bug is called Branch Type Confusion, with
> Retbleed (and Straight Line Speculation from previous disclosures) being
> two sub-cases of BTC.
> 
> > While ibpb might be available (and slow), on my Renoir with
> > microcode level (0860106h) there were no newer microcode versions
> > available when I last looked (a few weeks ago) but note 7 at the
> > bottom of
> > https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v
> > 7_20220712.pdf
> > implies that the relevant bit is only set on Renoir in 0860109h and
> > later.
> >
> > Some of the text in that pdf implies that at least one of the
> > options could be set if not already set from the microcode, but the
> > amount of detail leaves me totally lost.
> >
> > Assuming, for the moment, that I might want to try this full
> > mitigation, is there any way to set this in the absence of newer
> > microcode ?
> 
> The microcode doesn't matter.  All it does is automatically activate the
> same bit we set in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7caac991feeef1b871ee6988fd2c9725df09039
> 
> > Or should I just accept that the best I can get is 'unret', whatever
> > that means ?
> 
> "unret" fixes half the problem; the Retbleed subcase specifically.  You
> want IBPB if you want the full fix for Branch Type Confusion.
> 
> ~Andrew

Thanks.  In particular, thanks for the link to the commit which sets
that (I was hoping that had happened, but uncertain), and for
pointing out that the AMD and intel bugs are different (which a lot
of the online comments in various places seem to miss).

At the moment (desktop, single human user) I'm asking myself "Do ya
feel lucky ?" although I have not yet quite got as far as "Well do
ya, punk ?"

ĸen
-- 
 It is very easy to get ridiculously confused about the tenses of
 time travel, but most things can be resolved by a sufficiently
 large ego.        -- The Last Continent
