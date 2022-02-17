Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4254B9803
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiBQFKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiBQFKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:10:52 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9A79F2A5983;
        Wed, 16 Feb 2022 21:10:35 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 17 Feb 2022 13:10:17
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Thu, 17 Feb 2022 13:10:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        ruslan.bilovol@gmail.com, "Jing Leng" <jleng@ambarella.com>
Subject: Re: Re: [PATCH v3] usb: gadget: f_uac1: add different speed
 transfers support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YgzUJhcFk1FAKfJV@kroah.com>
References: <YgprpGbtBpojsCmQ@kroah.com>
 <20220215030848.5709-1-3090101217@zju.edu.cn> <Yguz4hOBYTXRL35t@kroah.com>
 <13396706.ae161.17f005864cf.Coremail.3090101217@zju.edu.cn>
 <YgzUJhcFk1FAKfJV@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <649b6b8a.a6d4b.17f06169537.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cC_KCgBHR2y52A1ix79kDQ--.23262W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwIEBVNG3FjlrQACsb
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
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

SGkgR3JlZyBLSCwKClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgoKSSB1bmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4gKFN0YXRpYyB2YXJpYWJsZXMgZG8gbm90IG5lZWQgdG8KIGJlIGV4cGxpY2l0bHkg
aW5pdGlhbGl6ZWQgdG8gMCkuCkkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoLCBhZGQgdGhlIGNoYW5n
ZSBsb2cgYW5kIHJlc2VuZCBpdC4KClRoYW5rcywKSmluZyBMZW5nCg==
