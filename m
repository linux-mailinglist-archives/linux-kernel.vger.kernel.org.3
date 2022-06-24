Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485A2559AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFXNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiFXNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:55:05 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E144766
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:55:00 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2BGBQA6wbViffxkzoFagliZDAEBAQaBQostA4EGhhaKO?=
 =?us-ascii?q?4FzAQEBAQEBAQEBCUIEAQFAig8nNwYOAQIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQcEFAEBIzwnhXWGewE7C4RLAYJnATOtL4EBhlkBgT+BZYE+iVaGX4EQh?=
 =?us-ascii?q?A9uhA8BCggBboVuBJlHCgMJBAcFRhcSTjEhAkULHAEIBgYHAQgBBQgoBAIBA?=
 =?us-ascii?q?QEGBRgUAQMBARMSBRMMBygKEgISDAobBwcDCwUyDQIOBwEBDA8BAg8DAQIRA?=
 =?us-ascii?q?QcCCRIIBg8rCAMBAQMBBwECAgMgCwIDFgkHCAIBAgUCAgEDDwEIChwSEBQCB?=
 =?us-ascii?q?A0EHgkCCAECGR4sBwICBA4DIx0ICwoDDgMEAwEQAhgHAgEVAQUCBAgEAQMGA?=
 =?us-ascii?q?wgVGQENJwQHAxICDQEGAQIGAQEFBQEDGAgDFAMFAQIIAxYHAQIhBQomCQQNA?=
 =?us-ascii?q?wEiGwIDAwEEGwoCAQICBRYFAgEBAgMCBhUGAgI/LxEdDQgECAQJEhwjAQIMA?=
 =?us-ascii?q?QQBAgcvBQQtAgEBHgQFAQUPAggBARYCBgQDAgIDAQECARYCEAgCCCcXBxMzG?=
 =?us-ascii?q?QEFNxQODwEDBggZHCIHCQcFBhYDDhUnHikFBxESGw8EDQ0KNCAWJAEBDgUDA?=
 =?us-ascii?q?RIZEQ4HFApTJiEVEAYBKxYDBAEDAwIGHAECAyUCEgYOBQEiHRmbD3sTgioVH?=
 =?us-ascii?q?5Jerm0Hg1EQAaAILZZiApIAlnCiCAxahE41gUKBD3BNI1CCaVAZD412AY57g?=
 =?us-ascii?q?S4CBgsBAQMJjEqCNwEB?=
IronPort-Data: A9a23:uaqjLqxLVKxoKS2/ZDN6t+e8xirEfRIJ4+MujC+fZmUNrF6WrkUAn
 GtMWGHQPqqIN2v2L4wnYIu19UNXuJGAzdZjTQJl+FhgHilAwSbnLY3EcR2gYX/6wu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bv656yMUOZigHtIQMsacUsxKbVIiGX1JZS5LwbZj2NY224ThWWthh
 PuryyHhEA79s9JLGj9Mg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdxMUdrJp8tuSH
 I4v+l0ZElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSiEais4G2PQghUh/u2yQufMgl
 49xrbexbhcob63lv+sbekwNe81+FfUuFL7vJHG+tZTKiVDAcj7szvRiAUU8MJcXvOp6aY1M3
 aVCeXZXNk7F3rruhujmEIGAhex6RCXvFJgUunVt1SnUF949XY3PBbjM5JpY0TY8i8REEOzRI
 cYUAdZqRE2dPUwVZQ1LUfrSms+Qnn7iVBwC6262rI8U6HCP3ApD/ZriZY+9ltuiHpkLwhzB/
 goq5V/RDQsXO9+f4T6E9G+8iOjSmy/yRIMVEvu/7PECqFmSwHEDTQYKXFS6p/aRjk+lR8kZL
 00S5zpooaUsnGSlFcL2X1u3oWKsuQMAX91XEKsx7wTl4q7V5RuJQ2sJVDhMbPQ4u8IsAz8nz
 FmEm5XuHzMHjVGOYXeU97PM9HWvPylQLWIDaSIARwYf7J/vrenfky4jUP5TSbeTrYyqQw3o6
 DGtvClvh5w0gsgigvDTEU/8vxqgoZ3ATwgQ7wrRX3644g4RWGJDT9H3gbQ8xasRRLt1XmVtr
 1BYypTHtL9m4YWlxHLdGLxl8KSBuq7dWAAwl2KDCLEN2lxBEVaDcIFc7TV0KV1mWirvUWG4O
 RWL0e+9zLVaMHasKJDct5itF8kvx6X6GrzYuh38a9NPZsAoMhKB/WRuaE+c0mTnnVIj160yU
 Xt6TSpOJShKYUiE5GPoLwv47VPN7ntirY80bcyipylLKZLEOBaopU4taTNilNwR4qKeuxny+
 N1CLcaMwBg3eLSgP3ePqd9LdwFSdiNT6XXKRyp/KLTrzu1ORj9JNhMt6ex5E2CYt/4Nx7qWp
 y/VtrFwkQKj2yGvxfq2hoBLM++xAcwm9RrXzAQmMFK3xnVrfICu8qoFbJorbPEh+fB8yuR3J
 8TpiO3fasmjvg/vpW9HBbGj99MKSfherVjTV8ZTSGRkIsQIqs2g0oOMQzYDAwFUX3Tu65dh8
 ub+vu4ZKLJaLzlf4A/tQKrH5zuMUbI1woqeg2OgzgFvRXjR
IronPort-HdrOrdr: A9a23:faNAlaOQD/WU6sBcTvijsMiBIKoaSvp037BL7TEJdfUxSKalfq
 +V7ZEmPHPP+VQssTQb6LO90cq7IE80l6QFhbX5VI3KNGLbUSmTTL2KhrGSpAEIdReOkNK1Fp
 0NT0G9MrDN5JRB4voSKTPXL+od
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2022 15:54:59 +0200
Received: from localhost (ip2505f6aa.dynamic.kabel-deutschland.de [37.5.246.170])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id A7DBB30011A56;
        Fri, 24 Jun 2022 15:54:58 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH v5 0/3] Staging: rtl8192e: Safer allocation and cleaner error handling
Date:   Fri, 24 Jun 2022 15:54:52 +0200
Message-Id: <cover.1656078068.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
  - replaced kmalloc with kzalloc against memory initialization defects,
    thus also removing a memset
  - made error handling more consistent

v3:
  - Split into smaller commits so that it's easier to review

v4:
  - clearer commit messages
  - added missing kfree

v5:
  - resend due incorrect email threading
    caused by using msmtp for send-email
    (probably some incorrect configuration on my part)
    Apologies for spamming greg k-h inbox/mailing list.

Felix Schlepper (3):
  Staging: rtl8192e: Use struct_size
  Staging: rtl8192e: Using kzalloc and delete memset
  Staging: rtl8192e: Cleaning up error handling

 drivers/staging/rtl8192e/rtllib_tx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.36.1

