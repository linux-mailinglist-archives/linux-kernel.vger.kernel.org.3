Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C95648B8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGCRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGCRBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:01:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DC6255;
        Sun,  3 Jul 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656867692;
        bh=EM1zIbFY/PJTPZZLlKcGTkRY1PczN69X+ZbPoyUQEKE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G3bWZbl2JaB90fUHC1g/izQgwL/3d0qlV6v3tSQBsHpG78BysBo4wC25NtNBrx7+w
         g8NIK7REGsDgO86K+v/Ja/wZBFFAh30H0gcqz8QZbdrFEj+0ajdJ618Pq4/bsHa+Fw
         DZ/8GBvzVjXF6R/mXyx70WHaNLXWwRBI9YBfofyQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([46.223.3.210]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MhU9Z-1ndOvI3izr-00eZYA; Sun, 03 Jul 2022 19:01:31 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 5/9] dt_bindings: rs485: Correct delay values
Date:   Sun,  3 Jul 2022 19:00:35 +0200
Message-Id: <20220703170039.2058202-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:bHhKUQrpvxEfQLDnA/B6qLNzCXgXuk8x5oOAJ9OM/fcBNvvd46G
 VxPFhxseBHLy1gfuNFr2susLgd2MviSP9QUS25CF/wjFGsoA8rBUkedVWueukBPXDSfTJKV
 30UFURnT7zuEzfu5WGVu9zv6a5/c4MAAM7wSNDzZKIHfx+Jlv2wFCVQSle/Cis61j0aJcW+
 eQ0cFQFwBIlPzZncLsjWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YCM95pyK50M=:PE9osGNTq6W4U2Rh6hQkj5
 gNeGezDhq2uT853atR4YjVF+lv2LA0J0RCzAqLNcaa/tr29AFLMfMGUGb6scYWaaDZTC5MGR9
 MBqqK5GZuMpJaORxsL7w9bKvUc6R3jAhUkPFKMaGNiYGLgE00OvJuPaKKOGQJWNeQrQtSCdwK
 0mR3m6uFg2KXC5OLBgL23mBJTbN9/cE5aB67jmC/Iko8Dqwzb7ObAST6WYEozpYbOfVNJJzNv
 7HZA7kwOZPNEYuWk1CxVPd6xFV67PQ7e2Cmy2Z96JLxixZGSbOQgNTzN8w7WroxnJWXKYbs2P
 wofIXXgBvl8LxvRg13h+ShDPOovMAD8tRhOuSugkws7LgGNQW/czWYxtjsfQ08YrVoZ/SCmNr
 6LvjijvBuk2jgVg2jCnpWIzeBcdC9LMzBiKC4SF/YcJFnuFA+zkyRzQ+W5fvrsMNbIZb2Un3E
 CZ33kuJnxTp63hoevF41AQ1AkkmRMkLvd5gLJUW3Ujxeplqny8ZBiBwK/ScGmGDr+kyku8r21
 ylmHYjYy3nmZAHI4MeGVUqb2W1aMYCDLd7qdLy2CM/fKRYdpGJpPz9VmNp7uOPILrKdymBBeM
 yI4ZOomHeR/Gev3rTSDICjpWVxmByA2c1B1Q/CQHTfWgMowtOetUVpHY/Oq5JZDjdq9OcXd+t
 txPq4f8xjdLll2cXy0PvgVuhLYaWyWCQVztT7QeikkK8aIR73oZ8XBDeu+V6dTG8nIh18rYCq
 DSvQ3pjORN/QMOZ0vv9o+D8Blp3VWUG8rBgeJJ+g3H00BXAp9mopGo/KB6CvbGK1QlzrU3+GW
 +yoRh19pkwRyHhOqKd39upyBQsLBz/X3FKVcErxHiBMUPFCEfweBvYQQ0bJuF7RtUfdyCmBfE
 yjwm5ggGIj0oXt2znPXEvi0rhFAXh4mvqlcW1QhNQVcKzcYa8g/4j9xPa/alKiAVp3NRBQg/Q
 +6ur7alcw3lfjAINLmzPIrSckkYVwSQ27LGrXX/qC+VlyYfW7FuLSdFAxMyhjI4crtsHIN57q
 7TBQX/Uez5KYyhSCiCd/CfTXd40cGVOBnN9mBRyLS+1Hn/FQspBp2iTlgYPtQeFCnP/HTlZ8A
 Ee9+4Z7cqNEMN4uoghE9Q/8p7abMwgTsXcCjgtIIEKh+2blSXRya4zjhA==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkN1cnJlbnRs
eSB0aGUgZG9jdW1lbnRhdGlvbiBjbGFpbXMgdGhhdCBhIG1heGltdW0gb2YgMTAwMCBtc2VjcyBp
cyBhbGxvd2VkCmZvciBSVFMgZGVsYXlzLiBIb3dldmVyIG5vdGhpbmcgYWN0dWFsbHkgY2hlY2tz
IHRoZSB2YWx1ZXMgcmVhZCBmcm9tIGRldmljZQp0cmVlL0FDUEkgYW5kIHNvIGl0IGlzIHBvc3Np
YmxlIHRvIHNldCBtdWNoIGhpZ2hlciB2YWx1ZXMuCgpUaGVyZSBpcyBhbHJlYWR5IGEgbWF4aW11
bSBvZiAxMDAgbXMgZW5mb3JjZWQgZm9yIFJUUyBkZWxheXMgdGhhdCBhcmUgc2V0CnZpYSB0aGUg
dWFydCBUSU9DU1JTNDg1IGlvY3RsLiBUbyBiZSBjb25zaXN0ZW50IHdpdGggdGhhdCB1c2UgdGhl
IHNhbWUKbGltaXQgZm9yIERUL0FDUEkgdmFsdWVzLgoKQWx0aG91Z2ggdGhpcyBjaGFuZ2UgaXMg
dmlzaWJsZSB0byB1c2Vyc3BhY2UgdGhlIHJpc2sgb2YgYnJlYWtpbmcgYW55dGhpbmcKd2hlbiBy
ZWR1Y2luZyB0aGUgbWF4IGRlbGF5cyBmcm9tIDEwMDAgdG8gMTAwIG1zIHNob3VsZCBiZSB2ZXJ5
IGxvdywgc2luY2UKMTAwIG1zIGlzIGFscmVhZHkgYSB2ZXJ5IGhpZ2ggbWF4aW11bSBmb3IgZGVs
YXlzIHRoYXQgYXJlIHVzdWFsbHkgcmF0aGVyIGluCnRoZSB1c2VjcyByYW5nZS4KClNpZ25lZC1v
ZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFtbApp
bmRleCBmMmM5YzlmZTZhYTcuLjkwYTFiYWI0MGYwNSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcnM0ODUueWFtbApAQCAtMjIsMTIgKzIyLDEy
IEBAIHByb3BlcnRpZXM6CiAgICAgICAgIC0gZGVzY3JpcHRpb246IERlbGF5IGJldHdlZW4gcnRz
IHNpZ25hbCBhbmQgYmVnaW5uaW5nIG9mIGRhdGEgc2VudCBpbgogICAgICAgICAgICAgbWlsbGlz
ZWNvbmRzLiBJdCBjb3JyZXNwb25kcyB0byB0aGUgZGVsYXkgYmVmb3JlIHNlbmRpbmcgZGF0YS4K
ICAgICAgICAgICBkZWZhdWx0OiAwCi0gICAgICAgICAgbWF4aW11bTogMTAwMAorICAgICAgICAg
IG1heGltdW06IDEwMAogICAgICAgICAtIGRlc2NyaXB0aW9uOiBEZWxheSBiZXR3ZWVuIGVuZCBv
ZiBkYXRhIHNlbnQgYW5kIHJ0cyBzaWduYWwgaW4gbWlsbGlzZWNvbmRzLgogICAgICAgICAgICAg
SXQgY29ycmVzcG9uZHMgdG8gdGhlIGRlbGF5IGFmdGVyIHNlbmRpbmcgZGF0YSBhbmQgYWN0dWFs
IHJlbGVhc2UKICAgICAgICAgICAgIG9mIHRoZSBsaW5lLgogICAgICAgICAgIGRlZmF1bHQ6IDAK
LSAgICAgICAgICBtYXhpbXVtOiAxMDAwCisgICAgICAgICAgbWF4aW11bTogMTAwCiAKICAgcnM0
ODUtcnRzLWFjdGl2ZS1sb3c6CiAgICAgZGVzY3JpcHRpb246IGRyaXZlIFJUUyBsb3cgd2hlbiBz
ZW5kaW5nIChkZWZhdWx0IGlzIGhpZ2gpLgotLSAKMi4yNS4xCgo=
