Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404F3593E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiHOUjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbiHOUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B4ABD60;
        Mon, 15 Aug 2022 12:06:23 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FI23UL000684;
        Mon, 15 Aug 2022 19:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=mufaP9+9c7b9pVorr0YTGCKgp71WgJtILQJnlfOl6W4=;
 b=cRF4ZnhCubZ4tgBXSY4DpcQJjBNo5PLlNOe+4tN96tLqcfXHMYGSkBsq+fx135w9S4RP
 G5fl2WkaVzcyyEDNgFjS3l0Jyf6BT4MXqmdDHfQ/BS6vBL15UULMsBvvlGn0wSKVZXYZ
 FMq/FXlqZ9wOz0ONwUHa62EUHJ9bpOYmy/D5jpu6AXwfeYJIJYBGiWbAa+1q4Xpd5PLK
 JyUUxeMr5k+000pKeeclL5SbIf1Vz/mP46ZhCT0zGIpfprobU2mjJ3nDfsV2z+IKpRvd
 oQ3BKQcNM+fybuRsDABcrcFNFlMeyWKVW4EUruid2l0B7XA6PTCCxcR+uysZtGIUaYEP uA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyts4rp7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:17 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 99183D2EB;
        Mon, 15 Aug 2022 19:06:16 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 153A9802BAD;
        Mon, 15 Aug 2022 19:06:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 0/8] crypto: Kconfig - simplify menus and help text
Date:   Mon, 15 Aug 2022 14:06:00 -0500
Message-Id: <20220815190608.47182-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6zWimYhHHpOz3MG_7T5hk9el344-e-uu
X-Proofpoint-GUID: 6zWimYhHHpOz3MG_7T5hk9el344-e-uu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=758 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the "make menuconfig" experience under the 
Cryptographic API page.

Robert Elliott (8):
  crypto: Kconfig - add submenus
  crypto: Kconfig - simplify public-key entries
  crypto: Kconfig - simplify user-space interface entries
  crypto: Kconfig - simplify AEAD and block mode entries
  crypto: Kconfig - simplify hash mode and digest entries
  crypto: Kconfig - simplify cipher, compression, and RNG entries
  crypto: Kconfig - sort the digests
  crypto: Kconfig - sort the ciphers

 crypto/Kconfig | 1511 +++++++++++++++++++++++++-----------------------
 1 file changed, 780 insertions(+), 731 deletions(-)

-- 
2.37.1

