Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6051EDC9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiEHNc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiEHNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 09:32:54 -0400
Received: from mail-m176230.qiye.163.com (mail-m176230.qiye.163.com [59.111.176.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC254BE0A;
        Sun,  8 May 2022 06:29:03 -0700 (PDT)
Received: from jmu.edu.cn (localhost [127.0.0.1])
        by mail-m176230.qiye.163.com (Hmail) with ESMTP id 773DE8600F3;
        Sun,  8 May 2022 21:29:01 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANAAfQDrFEUw2aEo5XZZDqq2.1.1652016541476.Hmail.201821123082@jmu.edu.cn>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogYWxsd2lubmVyOiBoNjogRW5hYmxlIENQVSBvcHAgdGFibGVzIGZvciBPcmFuZ2VQaSBPbmUgUGx1cw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 218.85.118.195
MIME-Version: 1.0
Received: from 201821123082@jmu.edu.cn( [218.85.118.195) ] by ajax-webmail ( [127.0.0.1] ) ; Sun, 8 May 2022 21:29:01 +0800 (GMT+08:00)
From:   Chukun Pan <amadeus@jmu.edu.cn>
Date:   Sun, 8 May 2022 21:29:01 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNNQkhWTU8dTh5LHh9DGB
        1PVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo1OjodKj8JPT4uDEkaPhROIyEh
        PwoKSVVKVUpNTklLSk1OT0pMQ0hVMxYaEhdVGhYaHx4OCDsRFg5VHh8OVRgVRVlXWRILWUFZSUpD
        VUNOVUpKQ1VKQk5ZV1kIAVlBSE9ISTcG
X-HM-Tid: 0a80a3d935e7d9a8kuws1809e65676a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlRoZSBBWFA4MDUgZGF0YXNoZWV0IGhhcyB0aGlzIGluZm9ybWF0aW9uIGluIHRoZSBkZXNjcmlw
dGlvbiBmb3IgUkVHIDFBLgo+RFZNIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQsIGFuZCB3aGVuIGl0
IGlzIGVuYWJsZWQsIHRoZSBkZWZhdWx0IHJhbXAgcmF0ZQo+aXMgMTBtVi8xNS42MjUgdXMgPT0g
NjQwIHVWL3VzLgo+Cj5EaWQgeW91IG5vdGljZSBhbnkgaW5zdGFiaWxpdHkgd2l0aG91dCB0aGlz
IGRlbGF5PwoKQWN0dWFsbHkgSSB3cml0ZSB0aGlzIGJhc2VkIG9uIHRoZSBjb21taXQgaHR0cHM6
Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC9lYmFlMzNjCigiYXJtNjQ6IGR0czog
YWxsd2lubmVyOiBoNjogRW5hYmxlIENQVSBvcHAgdGFibGVzIGZvciBPcmFuZ2UgUGkgMyIpIGFu
ZCBodHRwczovL2dpdGh1Yi5jb20vCnRvcnZhbGRzL2xpbnV4L2NvbW1pdC9mZTc5ZWE1ICgiYXJt
NjQ6IGR0czogYWxsd2lubmVyOiBoNjogRW5hYmxlIENQVSBvcHAgdGFibGVzIGZvciBQaW5lCkg2
NCIpLCBzbyBJIHRoaW5rIGl0J3MgbmVjZXNzYXJ5IHRvIGFkZCB0aGlzIGRlbGF5LgoKPj4gQEAg
LTIxNiw2ICsyMjIsNyBAQCByZWdfZGNkY2M6IGRjZGNjIHsKPj4gIAkJCQlyZWd1bGF0b3ItZW5h
YmxlLXJhbXAtZGVsYXkgPSA8MzIwMDA+Owo+PiAgCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDgxMDAwMD47Cj4+ICAJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTA4MDAwMD47
Cj4+ICsJCQkJcmVndWxhdG9yLXJhbXAtZGVsYXkgPSA8MjUwMD47Cj4KPlRoaXMgY2hhbmdlIGlz
IG5vdCByZWxhdGVkIHRvIENQVSBmcmVxdWVuY3kgc2NhbGluZywgc28gaXQgYmVsb25ncyBpbiBh
IHNlcGFyYXRlCj5wYXRjaCAoaWYgaXQgaXMgbmVlZGVkKS4KClRoZSB0d28gY29tbWl0cyBtZW50
aW9uZWQgYWJvdmUgYWxzbyBhZGQgdGhpcyBkZWxheSB0byBkY2RjYyByZWd1bGF0b3IuCklmIHRo
ZXJlIGlzIGEgbmVlZCBmb3IgYSBzZXBhcmF0ZSBwYXRjaCwgSSB3aWxsIHNlbmQgdGhlc2Ugc2Vw
YXJhdGVseS4KClRoYW5rcywKQ2h1a3VuCg0KDQo=
