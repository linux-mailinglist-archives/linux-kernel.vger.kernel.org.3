Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E3577D59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiGRITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiGRITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:19:04 -0400
Received: from smtpq2.tb.ukmail.iss.as9143.net (smtpq2.tb.ukmail.iss.as9143.net [212.54.57.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD56B849
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:19:03 -0700 (PDT)
Received: from [212.54.57.108] (helo=csmtp4.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1oDLy2-0005F5-06
        for linux-kernel@vger.kernel.org; Mon, 18 Jul 2022 10:19:02 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id DLy1opNWRuYlrDLy1oRSOL; Mon, 18 Jul 2022 10:19:01 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=RoXWkQqK c=1 sm=1 tr=0 ts=62d51775 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=RgO8CyIxsXoA:10 a=zd2uoN0lAAAA:8 a=GQgagVcjBMtnFRtF3loA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1658132341;
        bh=V/C/Yeyoys4o7TehoWP926lx5yRUap6C1609FFWebys=;
        h=Date:From:To:Subject;
        b=ayAh9nwgdvHBrFI2O1lMC0SOwn6F7sssbd3po5CaREv8eKmPuwfPDxGr8+mIVtbsU
         3i6wPRiFY0fXNPuizpu2rMah9nkOgl6FzwLFEhTVoQpffX/Va7ip4/N1x6NLHDvbY4
         HJk9KgzTiRoiHUFZNHeFsY7ybVEcfPMRwez3kddG59/RlN8zZWhyuiAEfSZ1Ub3szU
         lMqqiFmuzmrtLZ202oOe0YP2DHwQOoN/0ZCiItcQgqlBPCzpkb0kHho4GKfZKsXyzG
         Z4Ff6DMljuyPFNX62qEo3iay57fgYXKUtRT66Qjo/g2sb3Iq7paEz96wKua6Stkm5F
         YeAXjbz8zYrDQ==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 9E99A8DB5C; Mon, 18 Jul 2022 09:19:01 +0100 (BST)
Date:   Mon, 18 Jul 2022 09:19:01 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     linux-kernel@vger.kernel.org
Subject: Retbleed, Zen2 and STIBP
Message-ID: <YtUXda9ymAI0ED7n@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.6 (2022-06-05)
X-CMAE-Envelope: MS4xfFOLku9WgYEKmdRdm/nvrbE3/D3Bjzf4qmp/FnBsB+7V4z4de2bxFPo3SKLY3eahoww5E/zhi7TZVvbqGdVXb5m+wia/5hf51D0hiYA/myNgh17OOnP2
 gC9yyAqB/K51ojf2jhBa9cljxoFmBw9K4ACvDlOSNbg4NSExn94wFvSWlV1cMIawr3vI/HZR0ZOfc9Kfr7SNhy2nFm8FFcvTMP8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably like most people, I find the detail of the available
retbleed mitigations obscure.  In particular, for zen2 the options
*might* include ibpb or unret.

But I have failed to find what 'unret' actually means.  Any
pointers, please ?

While ibpb might be available (and slow), on my Renoir with
microcode level (0860106h) there were no newer microcode versions
available when I last looked (a few weeks ago) but note 7 at the
bottom of
https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion_v
7_20220712.pdf
implies that the relevant bit is only set on Renoir in 0860109h and
later.

Some of the text in that pdf implies that at least one of the
options could be set if not already set from the microcode, but the
amount of detail leaves me totally lost.

Assuming, for the moment, that I might want to try this full
mitigation, is there any way to set this in the absence of newer
microcode ?

Or should I just accept that the best I can get is 'unret', whatever
that means ?

ĸen
-- 
 It is very easy to get ridiculously confused about the tenses of
 time travel, but most things can be resolved by a sufficiently
 large ego.        -- The Last Continent
