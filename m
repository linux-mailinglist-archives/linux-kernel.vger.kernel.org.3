Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750064A6EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiBBKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:38:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:60560 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiBBKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:38:49 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220202103847epoutp046962ccf4dc412a1ea46212d3a8399796~P8d6jGdNt0362403624epoutp04T
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220202103847epoutp046962ccf4dc412a1ea46212d3a8399796~P8d6jGdNt0362403624epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643798327;
        bh=Wx8ROO8op3VTnOEzgAZLt9x0NeCwPv6eupDtuwPaXzw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MBjnLFWH3munjSxZuHkxDMbCbq6eVYwkIZ7lt6wXMXcNjjI+dcxEyI1rSkd3KShrL
         cp3otcnStMdY80uFbe2A3F/DfDd3IMim36z3D1Cbicn/1Qy08gM/YR8FZtVkm/0wHy
         ToIO57c0B/4Ay/jlOYiyTbSRj4e0/T3xec2DZAiU=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220202103847epcas5p39d6bcdd378ab9380554fcab835dc2c6e~P8d6IXn_v3184231842epcas5p3K;
        Wed,  2 Feb 2022 10:38:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.36.05590.63F5AF16; Wed,  2 Feb 2022 19:38:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220202103319epcas5p4ed4ae53759fc5c241bc8068132c989d7~P8ZJd7Uef0903109031epcas5p4Y;
        Wed,  2 Feb 2022 10:33:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220202103319epsmtrp1fe2c5a822bf6af3200f6c1fcf624a47f~P8ZJdJ_mH3005430054epsmtrp1B;
        Wed,  2 Feb 2022 10:33:19 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-11-61fa5f36fc73
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.A1.08738.FED5AF16; Wed,  2 Feb 2022 19:33:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220202103317epsmtip21b11c3fd8241b19a88a71f82c2fab296~P8ZHgBay02377923779epsmtip2o;
        Wed,  2 Feb 2022 10:33:17 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, markus@trippelsdorf.de,
        akpm@linux-foundation.org
Cc:     jack@suse.cz, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v3] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Date:   Wed,  2 Feb 2022 16:03:09 +0530
Message-Id: <20220202103309.1914992-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7bCmpq55/K9Eg/5nTBZz1q9hs/iwVsNi
        /cJlzBazpzczWcy+/5jF4vKuOWwWLUfbWSwOz29jsfj//zaTxb6OB0wWh07OZXTg9pjV0Mvm
        sXPWXXaPln232D1OzPjN4vFl1TVmj74tqxg9ziw4wu7Rv+sCk8fnTXIBnFFcNimpOZllqUX6
        dglcGc8mdzAWvBKueDK1lb2B8Y1AFyMnh4SAicSMT1eZuhi5OIQEdjNKHF87hxkkISTwiVFi
        3/IMiMRnRomLz46zwXS8efOPFSKxi1Fi24lfjBDOF0aJXZMXsoJUsQnoSazatYcFJCEi0Mso
        MeP1crAWZoHpjBJT5nSzgFQJC8RJvDq5mwnEZhFQlTg1+RpYnFfATuLx8QmMEPvkJWZe+s4O
        EReUODnzCVgNM1C8eetsZpChEgK9HBKP2nZCHegisWLtaiYIW1ji1fEt7BC2lMTL/jZ2iIZu
        RokN3cdYIJwZjBKfD16FWmcv8eQiyBMcQCs0Jdbv0ocIy0pMPbWOCWIzn0Tv7ydQC3gldsyD
        sVUlWm5uYIWwpSU+f/zIAmF7SDTMmsYCCdZYifWftjNOYJSfheShWUgemoWweQEj8ypGydSC
        4tz01GLTAuO81HK94sTc4tK8dL3k/NxNjOB0peW9g/HRgw96hxiZOBgPMUpwMCuJ8O5d+D1R
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO+p9A2JQgLpiSWp2ampBalFMFkmDk6pBiY504D9F13P
        XMpedfi7/rxfPVclV8X+YlghuMPPuNbp5NHSG+szC/Ys7p+7b+WRpgs+8a2PVkTuWnDO+a+b
        iZaEP8O0fx2HZQIfcf4KNr9hcKE69otVxSdupXlTtt6of35+9qzqVd1f3/LqMTfEfOv9Wf76
        /W6XSS1njPivPc43fxO1b/5pnY0LnY1SfuQ46cYkKf+/NnXZn7nL3eR5y/z9wgotM3uW3FzB
        aLhW4eH1epMj4Xz71D5brVFelfCk5v51SYEv4v3ujeteHeyV2zxhUVbvn2heN0/bD8tXKnBm
        Vv5Q8/Y62ljZa1P81OFXUwC7352Ff5tmuGxgN6iNVwjKWG+uwRPeriG1War9yxolluKMREMt
        5qLiRADUfbplxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvO772F+JBvueGlnMWb+GzeLDWg2L
        9QuXMVvMnt7MZDH7/mMWi8u75rBZtBxtZ7E4PL+NxeL//9tMFvs6HjBZHDo5l9GB22NWQy+b
        x85Zd9k9WvbdYvc4MeM3i8eXVdeYPfq2rGL0OLPgCLtH/64LTB6fN8kFcEZx2aSk5mSWpRbp
        2yVwZTyb3MFY8Eq44snUVvYGxjcCXYycHBICJhJv3vxj7WLk4hAS2MEoMfnQfVaIhLTEz3/v
        WSBsYYmV/56zg9hCAp8YJTadTQGx2QT0JFbt2sMC0iwiMJVR4t3VZewgDrPAbEaJe7sfgHUL
        C8RItO77ATaVRUBV4tTka2BxXgE7icfHJzBCbJCXmHnpOztEXFDi5MwnYDXMQPHmrbOZJzDy
        zUKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDYa2ntYNyz6oPeIUYm
        DsZDjBIczEoivHsXfk8U4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoR
        TJaJg1OqgWmNtbxiXs85gVK3q4rO15/86F7qK76YZabTbxav+05ff51nZ/3wh12m+llkyT7D
        f57Bf1b4MRyd9yqO6XlMv36a4f0JJkoiIfY2Jzo8F71liFssdvxj4I4bWd3MwWd+flafkdE7
        8XT02hC7Ez5R6z87OVxQUeQxllr38+DOWSUN705YCuv6v/57nGHiHp8ttndDzLJeNrc+skku
        //PVSfRAImP+G/YLbI+ahPMMj3FJyFzYt9k7nWmr06eU5W4v+DNm+XatMlr5QXLbkZ1LWxan
        uMkEz5S1j0pSYVVs2Ld98ctTL75NXbTh4MP9n5179wo6v9zv9OCmZ+JpJv1Nx7dZL7kswGB9
        5Xkh56llUzWVWIozEg21mIuKEwFGx7Rx6gIAAA==
X-CMS-MailID: 20220202103319epcas5p4ed4ae53759fc5c241bc8068132c989d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220202103319epcas5p4ed4ae53759fc5c241bc8068132c989d7
References: <CGME20220202103319epcas5p4ed4ae53759fc5c241bc8068132c989d7@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with commit 98e35f5894cf ("printk: git rid of [sched_delayed] message for
printk_deferred") printk_deferred and printk_deferred_once requires
LOGLEVEL in argument, but checkpatch.pl was not fixed and still reports
it as warning:

WARNING: Possible unnecessary KERN_ALERT
printk_deferred(KERN_ALERT "checking deferred\n");

As suggested by Andy, made 2 functions from logFunction.

1. logFunction: with all checks
2. logFunctionCore: without printk(?:_ratelimited|_once|_deferred) checking

and call logFunctionCore instead of logFunction for checking of loglevel,
which will exclude checking of printk(?:_ratelimited|_once|_deferred).

This way, there is no need to maintain same stanza at multipe places
for removing printk flavours.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2: made 2 functions to remove _deferred and _deferred_once
	as suggested by Andy Whitcroft.
v2-> v3: updated commit message with info of change in printk_deferred.
	https://lkml.org/lkml/2022/2/2/61

 scripts/checkpatch.pl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..a6fa0c7360be 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -584,8 +584,7 @@ our $typeTypedefs = qr{(?x:
 
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
 
-our $logFunctions = qr{(?x:
-	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
+our $logFunctionsCore = qr{(?x:
 	(?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
 	TP_printk|
 	WARN(?:_RATELIMIT|_ONCE|)|
@@ -594,6 +593,11 @@ our $logFunctions = qr{(?x:
 	seq_vprintf|seq_printf|seq_puts
 )};
 
+our $logFunctions = qr{(?x:
+	printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
+	$logFunctionsCore
+)};
+
 our $allocFunctions = qr{(?x:
 	(?:(?:devm_)?
 		(?:kv|k|v)[czm]alloc(?:_array)?(?:_node)? |
@@ -6298,8 +6302,7 @@ sub process {
 		}
 
 # check for logging functions with KERN_<LEVEL>
-		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
-		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
+		if ($line =~ /\b$logFunctionsCore\s*\(.*\b(KERN_[A-Z]+)\b/) {
 			my $level = $1;
 			if (WARN("UNNECESSARY_KERN_LEVEL",
 				 "Possible unnecessary $level\n" . $herecurr) &&
-- 
2.17.1

