Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636C4B7DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiBPCZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:25:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiBPCZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:25:03 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BFD8BDBD04;
        Tue, 15 Feb 2022 18:24:49 -0800 (PST)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 16 Feb 2022 10:24:27
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Wed, 16 Feb 2022 10:24:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5Ya36Z2Z?= <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, "Jing Leng" <jleng@ambarella.com>
Subject: Re: [PATCH v3] usb: gadget: f_uac1: add different speed transfers
 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Yguz4hOBYTXRL35t@kroah.com>
References: <YgprpGbtBpojsCmQ@kroah.com>
 <20220215030848.5709-1-3090101217@zju.edu.cn> <Yguz4hOBYTXRL35t@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <13396706.ae161.17f005864cf.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: by_KCgDHzyNbYAxiX7DrAQ--.38527W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwMDBVNG3FigQAAAs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKClNvcnJ5IGZvciB0aGUgdHJvdWJsZSwgYXMgYSBuZXcgY29udHJpYnV0b3Ig
dG8ga2VybmVsLgpBbHRob3VnaCBJIGhhdmUgcmVhZGVkIHRoZSBkb2N1bWVudCB0aGF0IGhvdyB0
byBzdWJtaXQgcGF0Y2hlcywKSSdtIHN0aWxsIG1pc3Npbmcgc29tZSBkZXRhaWxzLgoKPiBXaGVy
ZSBpcyB0aGUgcGF0Y2ggdmVyc2lvbiBpbmZvcm1hdGlvbj8KVGhlIG5ldyBwYXRjaCBhZGRzIG1v
cmUgZGV0YWlsZWQgcGF0Y2ggZGVzY3JpcHRpb24gYW5kIGFkZHMKJ3N0YXRpYycgYmVmb3JlICdz
dHJ1Y3QgdXNiX3NzX2VwX2NvbXBfZGVzY3JpcHRvciBhY19pbnRfZXBfZGVzY19jb21wJy4KCj4g
V2h5IGFyZSB5b3Ugc2V0dGluZyB2YWx1ZXMgdG8gMCB3aGVuIHlvdSBkbyBub3QgaGF2ZSB0byBh
cyB0aGF0IGlzIHRoZQo+IGRlZmF1bHQgdmFsdWU/ClRoaXMgbW9kaWZpY2F0aW9uIGlzIHNpbWls
YXIgdG8gdWFjMi4KT24gcGFnZSAzNjIgb2YgdGhlIFVTQjMuMiBzcGVjaWZpY2F0aW9uLgpiTWF4
QnVyc3QgaXMgMCBtZWFucyB0aGF0IG5vIGJ1cnN0IHRyYW5zZmVyLgpibUF0dHJpYnV0ZXMgaXMg
MCBtZWFucyB0aGF0IG5vIG11bHQuClNvIHRoZSAiTWF4aW11bSBudW1iZXIgb2YgcGFja2V0cyA9
IChiTWF4QnVyc3QgKyAxKSB4IChNdWx0ICsgMSkiIGlzIDEuCgo+IFRoZSBhYm92ZSBjaGFuZ2Ug
aXMgbm90IG5lZWRlZCBoZXJlLgpOb3RpY2UgdGhpcyBtb2RpZmljYXRpb24gc3R5bGUuCgp0aGFu
a3MsCgpKaW5nIExlbmcK
