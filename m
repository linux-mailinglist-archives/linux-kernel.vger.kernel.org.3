Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB265B1271
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIHCZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIHCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:25:30 -0400
Received: from m139.mail.163.com (m139.mail.163.com [220.181.13.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 948CC7AC17
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=qbJYb
        4bVITOg8OhdAmppbUTTwKaAeKN83YyC043y728=; b=GMDvzX4NaCU+1oNwwETLL
        uk25iw974lityHaS4YJXlj1aKrHi3rYzxWu6sDsGCKiWVmGf+LYaAS5FqiBzVC9a
        +/mM6rPpQjoixn1y7HPy4o1/QWDZLzkBoXuuX6OxQtlDaDOhoDK7jD1a/MnlXmsD
        A9PWkYEsa0b0/3Bekmcj0g=
Received: from 13667453960$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr9 (Coremail) ; Thu, 8 Sep 2022 10:24:55 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Thu, 8 Sep 2022 10:24:55 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     richard.genoud@gmail.com, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] tty: serial: atmel: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YxiP3NfgH+2iIiXy@kroah.com>
References: <20220906063957.2951323-1-13667453960@163.com>
 <YxiP3NfgH+2iIiXy@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <d600b6b.e8c.1831aea231e.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcGowABHJ153UhljI3YqAA--.50479W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyBd2+1p7HojPGAACsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMDktMDcgMjA6MzQ6MzYsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMDI6Mzk6NTdQTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4+IAo+PiBGaXggc3BlbGxpbmcgdHlwbyBpbiBjb21tZW50Lgo+PiAKPj4gUmVw
b3J0ZWQtYnk6IGsyY2kgPGtlcm5lbC1ib3RAa3lsaW5vcy5jbj4KPgo+V2hhdCBpcyAiazJjaSI/
CgpUaGUgazJjaSBpcyBhbiBhdXRvbWF0ZWQgY29tcGlsYXRpb24sIGRldGVjdGlvbiBhbmQgdGVz
dGluZyBwbGF0Zm9ybSBidWlsdCBieSB0aGUgY29tcGFueaGjSnVzdCBsaWtlIHRoZSBrZXJuZWwg
dGVzdCByb2JvdCBidWlsdCBieSBJbnRlbKGjClNvIEkgd3JpdGUgbGlrZSB0aGlzo7oKUmVwb3J0
ZWQtYnk6IGsyY2kgPGtlcm5lbC1ib3RAa3lsaW5vcy5jbj4KUmVmZXIgdG8gdGhlIGZvbGxvd2lu
ZzoKUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgpEb2N1bWVu
dGF0aW9uL3Byb2Nlc3MvcmVzZWFyY2hlci1ndWlkZWxpbmVzLnJzdAoKdGhhbmtzLAoKSmlhbmdz
aGFuIFlp
