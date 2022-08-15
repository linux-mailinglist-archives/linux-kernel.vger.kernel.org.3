Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1255928C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiHOEaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240682AbiHOEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:30:01 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF012A84;
        Sun, 14 Aug 2022 21:30:00 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27F4RPCF015521;
        Mon, 15 Aug 2022 04:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=M2k9ZH1UeatfnvLpeC2WHBQu6VjBd/QAdbdqkkzPTR4=;
 b=SCcY7D8+V/IOuyU5hfCvLisveU0j7/a+JW7DhjsFGo+tpv77n4OjlqsvivByWz/0i0Qy
 tpQmiWdeap4roIuyWcm8Qkg5DSVgZHliZuQeW1pAFlJwAYjKB9fJDg01aITEw5DXk6Ca
 qWL56X+efyOSjtsx84CVTGCyBCByOYjExoQCnEMLfPc9OJAhzo9uYhmVE29zliyTL8PH
 M/+2LbSG5XpJYGwnSPScBkD2oiMqw7F5PC+b+drG5uhvVnLRJQhFqMwW0W6b08CEkK3w
 L5iHLS+1s6jzoktqS8TIcQ7ETugIvaThsmWQW6kqaRC8YcdZEuNU6jLfntHr11wkZzkk Ow== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyf4mr0e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 04:29:21 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 2A9B5804CA7;
        Mon, 15 Aug 2022 04:29:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9D5F280A443;
        Mon, 15 Aug 2022 04:29:20 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH] crypto: tcrypt - remove mode=1000
Date:   Sun, 14 Aug 2022 23:29:15 -0500
Message-Id: <20220815042915.44547-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nlXijbdXG3OM-8qOHcP89z03yXWQ8_tM
X-Proofpoint-ORIG-GUID: nlXijbdXG3OM-8qOHcP89z03yXWQ8_tM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150016
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lists of algothms checked for existence by
    modprobe tcrypt mode=1000
generates three bogus errors:
    modprobe tcrypt mode=1000

    console log:
    tcrypt: alg rot13 not found
    tcrypt: alg cts not found
    tcrypt: alg arc4 not found

rot13 is not an algorithm in the crypto API or tested.

cts is a wrapper, not a base algorithm.

arc4 is named ecb(arc4), not arc4.

Also, the list is missing numerous algorithms that are tested by
other test modes:
    blake2b-512
    blake2s-256
    crct10dif
    xxhash64
    ghash
    cast5
    sm4
    ansi_prng

Several of the algorithms are only available if
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is enabled:
    arc4
    khazad
    seed
    tea, xtea, xeta

Rather that fix that list, remove test mode=1000 entirely.
It seems to have limited utility, and a web search shows no
discussion of anybody using it.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/tcrypt.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 2bacf8384f59..35d70382ee54 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -65,18 +65,6 @@ static int mode;
 static u32 num_mb = 8;
 static unsigned int klen;
 static char *tvmem[TVMEMSIZE];
-
-static const char *check[] = {
-	"des", "md5", "des3_ede", "rot13", "sha1", "sha224", "sha256", "sm3",
-	"blowfish", "twofish", "serpent", "sha384", "sha512", "md4", "aes",
-	"cast6", "arc4", "michael_mic", "deflate", "crc32c", "tea", "xtea",
-	"khazad", "wp512", "wp384", "wp256", "xeta",  "fcrypt",
-	"camellia", "seed", "rmd160",
-	"lzo", "lzo-rle", "cts", "sha3-224", "sha3-256", "sha3-384",
-	"sha3-512", "streebog256", "streebog512",
-	NULL
-};
-
 static const int block_sizes[] = { 16, 64, 128, 256, 1024, 1420, 4096, 0 };
 static const int aead_sizes[] = { 16, 64, 256, 512, 1024, 1420, 4096, 8192, 0 };
 
@@ -1454,18 +1442,6 @@ static void test_cipher_speed(const char *algo, int enc, unsigned int secs,
 				   false);
 }
 
-static void test_available(void)
-{
-	const char **name = check;
-
-	while (*name) {
-		printk("alg %s ", *name);
-		printk(crypto_has_alg(*name, 0, 0) ?
-		       "found\n" : "not found\n");
-		name++;
-	}
-}
-
 static inline int tcrypt_test(const char *alg)
 {
 	int ret;
@@ -2825,10 +2801,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		test_mb_skcipher_speed("ctr(blowfish)", DECRYPT, sec, NULL, 0,
 				       speed_template_8_32, num_mb);
 		break;
-
-	case 1000:
-		test_available();
-		break;
 	}
 
 	return ret;
-- 
2.37.1

