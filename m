Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E490081
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiAQDPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:15:22 -0500
Received: from mwweb08oc.mail2world.com ([74.202.142.113]:49732 "EHLO
        mwweb08oc.m2wprod.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230324AbiAQDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:15:21 -0500
X-Greylist: delayed 1082 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jan 2022 22:15:21 EST
Received: from mail pickup service by mwweb08oc.m2wprod.com with Microsoft SMTPSVC;
         Sun, 16 Jan 2022 18:59:00 -0800
Received: from mail pickup service by mwweb08oc.mail2world.com with Microsoft SMTPSVC;
         Sun, 16 Jan 2022 18:58:56 -0800
auth-sender: gheskett@shentel.net
Received: from 204.111.64.149 unverified ([204.111.64.149]) by mwweb08oc.mail2world.com with Mail2World SMTP Server; 
        Sun, 16 Jan 2022 18:58:56 -0800
From:   gene heskett <gheskett@shentel.net>
To:     linux-kernel@vger.kernel.org
Subject: What replaces the 4.19.y scripts/mkknlimg in 5.16-rc6-rt12?
Date:   Sun, 16 Jan 2022 21:56:48 -0500
Message-ID: <3003419.O0OFyGy2SB@coyote>
Organization: only accidental
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A702F1B.61E4DAF1.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-OriginalArrivalTime: 17 Jan 2022 02:58:56.0604 (UTC) FILETIME=[2B1C01C0:01D80B4E]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

That script/mkknlimg is missing in v5.16-rc6-rt2. What replaces it?

Or, can this script be copied to a v5.16-rc6-rt12 build and used?

Thanks a bunch, I'm trying to build a v5.16-rc6-rt12 on a rpi4 for the 
rpi4. The build itself was flawless.

Cheers, Gene Heskett.
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author, 1940)
If we desire respect for the law, we must first make the law respectable.
 - Louis D. Brandeis
Genes Web page <http://geneslinuxbox.net:6309/gene>



