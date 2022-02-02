Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214EA4A6C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiBBHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:32:00 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22227 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiBBHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:31:39 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220202073137epoutp03ce7a523d2d78c70d359ef9aa8248ee77~P56fhBiqu3217332173epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:31:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220202073137epoutp03ce7a523d2d78c70d359ef9aa8248ee77~P56fhBiqu3217332173epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643787097;
        bh=yqcm3oZY9JzuPvkNa0W1U0xYuUGGav2iywp4rUB8DgU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rtTKOCidXg9VxghQq4MzGta6IgfKFiovkB8oAM+OOmNr1yirvlRWLwEq3Kjgz1kfD
         tYXgpkPlxUyLS8T4Fl4V2rgfQsR37ro/cDLpBGMN6jNzmsokxHqEXHILWCtNi54YZE
         Gqfnygv1jtTXJWsscuKa1/WPYvzxax3pXZKZmL3c=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220202073136epcas5p1e86388f436d053e74abb855b9e941326~P56fNEbEN2123821238epcas5p1c;
        Wed,  2 Feb 2022 07:31:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.06.46822.8F23AF16; Wed,  2 Feb 2022 16:30:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919~P5rUCXDDW1421914219epcas5p1i;
        Wed,  2 Feb 2022 07:14:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220202071414epsmtrp13fcd5e30b3f04ea14a1abf5b275c83cc~P5rUBqV3y0935409354epsmtrp15;
        Wed,  2 Feb 2022 07:14:14 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-56-61fa32f875d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.28.29871.54F2AF16; Wed,  2 Feb 2022 16:14:13 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220202071412epsmtip2af2fb1c2b7a5bcadc3f873091da19c68~P5rSq-5Au3149931499epsmtip2Z;
        Wed,  2 Feb 2022 07:14:12 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH RESEND v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Date:   Wed,  2 Feb 2022 12:44:05 +0530
Message-Id: <20220202071405.1872044-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdlhTU/eH0a9Egzk3OSw+rNWwWL9wGbPF
        7PuPWSwu75rDZtFytJ3F4vD8NhaLQyfnMjqwe8xq6GXz2DnrLrvHl1XXmD36tqxi9Pi8SS6A
        NYrLJiU1J7MstUjfLoEro/vBRZaCBqGK/U82sDcwLubvYuTkkBAwkZg37zxjFyMXh5DAbkaJ
        rr2X2SCcT4wSf7dcZodwvjFKvP/YDFTGAdayYUoJRHwvo8TaoytZIJwvjBKX301kBZnLJqAn
        sWrXHhYQW0QgSqJr2VlGEJtZoEjiy7VOsEHCAqkSmyYJgZgsAqoSn/7IgVTwCthJvJ/0jR3i
        OnmJmZe+s0PEBSVOznzCAjFFXqJ562xmkLUSAufYJY5M/c0G0eAisW3lSqhmYYlXx7dA2VIS
        L/vb2CEauhklNnQfY4FwZjBKfD54lRGiyl7iycWFrCAXMQtoSqzfpQ8RlpWYemodE8RmPone
        30+YIOK8EjvmwdiqEi03N7BC2NISnz9+ZIGwPSS2tG8AO05IIFai+flU1gmM8rOQPDQLyUOz
        EDYvYGRexSiZWlCcm55abFpglJdarlecmFtcmpeul5yfu4kRnFa0vHYwPnzwQe8QIxMH4yFG
        CQ5mJRHevQu/JwrxpiRWVqUW5ccXleakFh9ilOZgURLnPZ2+IVFIID2xJDU7NbUgtQgmy8TB
        KdXAtPmSx4Somt+HvFf8WBielqLxePLRPK0LO/ha5y29tWblQvashycVbs1Xt2tP1Etm2xtr
        5uU0KTr6mf/v9Lqnj/97brFonGCbaqnge8Rvf95Ss4bK5SLl8g781hu3XHj3JGvi83ipjKLe
        Vt+bvy9zfPN55705dqOhj0+31OarB4t4antVXhamr1t1aPnZvriVcmJTb+7S631jZd/ZxmXN
        oe8uI560ztM8QF70WOr2ooinh63/fQ5dzr5uuvo1j/jthfNeL7IVaRdb+vua/rsW15SKCaaN
        L5sm+fE0r3MttJDckRWzc8fhBUFGiw6GtP7x8m/NK2OeI38lOWvmTubs5gDZv/qP/J0S+8XX
        xLMpsRRnJBpqMRcVJwIApMTD8JoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvK6r/q9Eg7nPDSw+rNWwWL9wGbPF
        7PuPWSwu75rDZtFytJ3F4vD8NhaLQyfnMjqwe8xq6GXz2DnrLrvHl1XXmD36tqxi9Pi8SS6A
        NYrLJiU1J7MstUjfLoEro/vBRZaCBqGK/U82sDcwLubvYuTgkBAwkdgwpaSLkYtDSGA3o8Sy
        iesZuxg5geLSEj//vWeBsIUlVv57zg5R9IlRYuO7xWBFbAJ6Eqt27QErEhGIk5h8dAkzyFBm
        gRKJn3u8QcLCAskS/0/dYgQJswioSnz6IwcS5hWwk3g/6Rs7xHh5iZmXvrNDxAUlTs58AjaR
        GSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOTy3N
        HYzbV33QO8TIxMF4iFGCg1lJhHfvwu+JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTBZyv5OFeQ+/2H22+7SSdKfxEI7L+ZO9JrUZem/nOXbuSo56xL9
        QxGTd383ncF8Ntc/qXOFW8KD0C++wdL2fBy1+i/LWt+2Rl4477c0w5s3yfnePJfLIdJdV3QP
        TJGd7P24hvnjpC2zb07dENBgerZWJSe9aJVRWdy3hs/eXM2XRK6n87461JM+c02x3OOqls9Z
        CUwsTlenb2ea7MdZeKlYQjHDMITjiM+iRX/ezp+eNHF7DrulUJTe8ubfD99Vvlf1Kl88Q55h
        y5mdHqveyf715xXnDBJZZXq54ZvkUv3Wy9UnDXLS9D5vKz5y9dSDd6w+6m+Ml/7dJirQaDvJ
        n/u9gfwayRV67cIJZ5T63ymxFGckGmoxFxUnAgB0KtzpvgIAAA==
X-CMS-MailID: 20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919
References: <CGME20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk_deferred and printk_deferred_once requires LOGLEVEL in argument,
but checkpatch.pl reports it as warning:

WARNING: Possible unnecessary KERN_ALERT
printk_deferred(KERN_ALERT "checking deferred\n");

As suggested by Andy, made 2 functions from logFunction.

1. logFunction: with all checks
2. logFunctionCore: without printk(?:_ratelimited|_once|_deferred) checking

and call logFunctionCore instead of logFunction for checking of loglevel,
which will exclude checking of printk(?:_ratelimited|_once|_deferred).

This way, there is no need to maintain same stanza at  places for removing
printk flavours.

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2: made 2 functions to remove _deferred and _deferred_once
	as suggested by Andy Whitcroft.

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

