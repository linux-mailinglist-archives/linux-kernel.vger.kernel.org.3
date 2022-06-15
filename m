Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A954C77C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbiFOL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFOL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:27:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A14BFF3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:27:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h19so11707061wrc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=IhOUdxeqFxT9/z4e6PK90p05ZQlPbYBKKbitmxcpYRk=;
        b=LlI0oKYG0l00L0BJ/GV8nuY1SIC/Y7H8BVmHysxUgCeZVnFmKuFcDyt4pZPFZqpU5s
         jjaKIcd5tXYdtkRZc/Lqyem3fm4Z6vNZNH4Tmh5ubauTeV2RJ4Bl5g+2y+apsKiXPR1V
         TPdcU3EORNfnPG16jNpckb1U8lU5wjky9M5LfYJK5jJqioN3pK/P4cNEmHKqlJm9it2K
         SjgJ+TW39XjU93t7StEf0+zP1HtO29X3tfFh97hjwMHrAlEOvifnWxSx24JJWgXc9vHe
         amcZWENYbfsR1wFpxPigT6Uww8bCGdyj0W8MkDsgTbX+qst5DrABm365Jp2jEBnYqoIr
         GOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=IhOUdxeqFxT9/z4e6PK90p05ZQlPbYBKKbitmxcpYRk=;
        b=nCd66l2OrtHN3WBIkJzS94vJyWFJxY9ib8ISUij381ojvBZ89JTDYSFTJQR1DO/mLm
         sStPfAu4RbFyonsuer/cttZctV/NGPYlY6HHH8ep0aQNNZoreyJ+GmmMH7FL6lYDSdnZ
         1DZ8EgEchYqnBSGQlmPm5SArEDMf7z/FXh3x8XGhlpFpOOzsZyrAPJPktfvWgHdMLmyu
         J+o9ZEo4rX84nPVnjvEk4yv9qANzx8Eh1XkBdkBRv6yrtO+OIY4xwp1v4tStRwKMEOrs
         wg+o88d++xDhdvcHiu0mK1wrjzuLjYk8Pq1Ynyd0/BnuVVYNAo7RTWmUDTleRea8bQPo
         nMbg==
X-Gm-Message-State: AJIora8b90wW0avnKVp47lM3uh+AIW2JvYNt6OREMsKKQB698MW4c5/r
        cSiyz3Nke9j+ouiCiC6JKSAe8w==
X-Google-Smtp-Source: AGRyM1utOhDyfAvpniPmWvhl3dXjAzRtFhRKpReaoNS9Wq8f0gFvHyCfaajCnrqis9je+tjDXVH/tw==
X-Received: by 2002:a05:6000:381:b0:219:b933:38 with SMTP id u1-20020a056000038100b00219b9330038mr9803183wrf.15.1655292429887;
        Wed, 15 Jun 2022 04:27:09 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d6a0c000000b0020cdcb0efa2sm14324891wru.34.2022.06.15.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 04:27:09 -0700 (PDT)
Message-ID: <c7406d58-1615-3b58-0f0b-8a0b9efa1dd6@conchuod.ie>
Date:   Wed, 15 Jun 2022 12:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [Re-PATCH] arch: arm: mach-pxa: Add missing of_node_put
 in irq.c
Content-Language: en-US
To:     "windhl@126.com" <windhl@126.com>, heliang <windhl@126.com>,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
References: <20220615103332.3963303-1-windhl@126.com>
 <aa7254a0-c7ce-3092-2da6-020ffef80142@conchuod.ie>
 <202206151925336656862@126.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <202206151925336656862@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDYvMjAyMiAxMjoyNSwgd2luZGhsQDEyNi5jb20gd3JvdGU6DQo+IFNvcnJ5IGZv
ciBteSB0cm91YmxlLiBTbyBJIHdvbmRlciBpZiBJIGhhdmUgdG8gbWFrZSBhbm90aGVyIHZl
cnNpb24gcGF0Y2ggdG8gY29tcGxldGUgdGhlc2UgdGFza3MgaW4gdGhpcyBjb21taXQ6DQo+
IA0KPiAoMSkgdXNlIC12IE4gdG8gYXV0b21hdGljYWxseSBtZWFuIFtQQVRDSCB2Ml0NCj4g
KDIpIHVzZSBhIGZvcm1hbCByZWFsIG5hbWUsIG15IHJlYWwgbmFtZSBpcyBMaWFuZyBIZQ0K
DQpUaGlzIG9uZSBuZWVkcyB0byBiZSBhIHJlc2VuZCBJIHRoaW5rLCBzbyAoMSkgYXBwbGll
cyB0b28NCg0KPiAoMykgYWRkIGNoYW5nZWxvZw0KDQpBbmQgc2luY2UgeW91J3JlIHJlc2Vu
ZGluZyBhbnl3YXksIHllYWggYWRkIGEgY2hhbmdlbG9nLg0KDQpUaGFua3MsDQpDb25vci4N
Cg0KPiANCj4gb3IgY29tcGxldGUgdGhlc2UgdGFza3MgaW4gZnV0dXJlIHBhdGNoIGNvbW1p
dD8NCj4gDQo+IFRoYW5rcyENCj4gDQo+IExpYW5nDQo+IA0KPiANCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IHdpbmRobEAxMjYuY29tDQo+IA0KPiAgICAgKkZyb206KiBDb25vciBEb29s
ZXkgPG1haWx0bzptYWlsQGNvbmNodW9kLmllPg0KPiAgICAgKkRhdGU6KsKgMjAyMi0wNi0x
NcKgMTg6NDINCj4gICAgICpUbzoqIGhlbGlhbmcgPG1haWx0bzp3aW5kaGxAMTI2LmNvbT47
IGRhbmllbCA8bWFpbHRvOmRhbmllbEB6b25xdWUub3JnPjsgaGFvamlhbi56aHVhbmcgPG1h
aWx0bzpoYW9qaWFuLnpodWFuZ0BnbWFpbC5jb20+OyByb2JlcnQuamFyem1payA8bWFpbHRv
OnJvYmVydC5qYXJ6bWlrQGZyZWUuZnI+OyBsaW51eCA8bWFpbHRvOmxpbnV4QGFybWxpbnV4
Lm9yZy51az4NCj4gICAgICpDQzoqIGxpbnV4LWFybS1rZXJuZWwgPG1haWx0bzpsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eC1rZXJuZWwgPG1haWx0bzps
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiAgICAgKlN1YmplY3Q6KsKgUmU6IFtQ
QVRDSF0gW1JlLVBBVENIXSBhcmNoOiBhcm06IG1hY2gtcHhhOiBBZGQgbWlzc2luZyBvZl9u
b2RlX3B1dCBpbiBpcnEuYw0KPiAgICAgT24gMTUvMDYvMjAyMiAxMTozMywgaGVsaWFuZyB3
cm90ZToNCj4gICAgICA+IFtQQVRDSF0gW1JlLVBBVENIXSBhcmNoOiBhcm06IG1hY2gtcHhh
OiBBZGQgbWlzc2luZyBvZl9ub2RlX3B1dCBpbiBpcnEuYw0KPiAgICAgWW91IG1lYW4gW1BB
VENIIHYyXT8gUGFzcyAtdiBOIGFyZyB0byBmb3JtYXQtcGF0Y2ggJiBpdCdsbCBkbyBpdA0K
PiAgICAgZm9yIHlvdS4NCj4gICAgICA+IEluIHB4YV9kdF9pcnFfaW5pdCgpLCBvZl9maW5k
X21hdGNoaW5nX25vZGUoKSB3aWxsIHJldHVybiBhIG5vZGUNCj4gICAgICA+IHBvaW50ZXIg
d2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCBp
bg0KPiAgICAgID4gZmFpbCBwYXRoIG9yIHdoZW4gaXQgaXMgbm90IHVzZWQgYW55bW9yZS4g
VGhpcyBnb3RvLWxhYmVsIHBhdGNoDQo+ICAgICAgPiBzdHlsZSBpcyBhZHZpc2VkIGJ5IERh
bmllbC4NCj4gICAgICA+DQo+ICAgICAgPiBTaWduZWQtb2ZmLWJ5OiBoZWxpYW5nIDx3aW5k
aGxAMTI2LmNvbT4NCj4gICAgIE9uIGFsbCB0aGVzZSBwYXRjaGVzLCBpcyAiaGVsaWFuZyIg
eW91ciAoZnVsbCkgcmVhbCBuYW1lPw0KPiAgICAgU2VlOg0KPiAgICAgaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMu
aHRtbCNkZXZlbG9wZXItcy1jZXJ0aWZpY2F0ZS1vZi1vcmlnaW4tMS0xDQo+ICAgICAgPiAt
LS0NCj4gICAgIEl0J3MgaGVscGZ1bCB0byBwdXQgYSBjaGFuZ2Vsb2cgaGVyZSB0b28gZm9y
IHdoYXQgY2hhbmdlZCBzaW5jZSB2MQ0KPiAgICAgID7CoMKgIGFyY2gvYXJtL21hY2gtcHhh
L2lycS5jIHwgOSArKysrKystLS0NCj4gICAgICA+wqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAgICAgID4NCj4gICAgICA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9pcnEuYyBiL2FyY2gvYXJtL21hY2gtcHhhL2ly
cS5jDQo+ICAgICAgPiBpbmRleCA5NmYzM2VmMWQ5ZWEuLjMzODM1NmI5ZjM3YyAxMDA2NDQN
Cj4gICAgICA+IC0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2lycS5jDQo+ICAgICAgPiArKysg
Yi9hcmNoL2FybS9tYWNoLXB4YS9pcnEuYw0KPiAgICAgID4gQEAgLTI0NywxMyArMjQ3LDEz
IEBAIHZvaWQgX19pbml0IHB4YV9kdF9pcnFfaW5pdChpbnQgKCpmbikoc3RydWN0IGlycV9k
YXRhICosIHVuc2lnbmVkIGludCkpDQo+ICAgICAgPsKgwqAgwqDCoCAmcHhhX2ludGVybmFs
X2lycV9ucik7DQo+ICAgICAgPsKgwqAgaWYgKHJldCkgew0KPiAgICAgID7CoMKgIHByX2Vy
cigiTm90IGZvdW5kIG1hcnZlbGwsaW50Yy1uci1pcnFzIHByb3BlcnR5XG4iKTsNCj4gICAg
ICA+IC0gcmV0dXJuOw0KPiAgICAgID4gKyBnb3RvIG91dF9wdXQ7DQo+ICAgICAgPsKgwqAg
fQ0KPiAgICAgID4NCj4gICAgICA+wqDCoCByZXQgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNl
KG5vZGUsIDAsICZyZXMpOw0KPiAgICAgID7CoMKgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAg
PsKgwqAgcHJfZXJyKCJObyByZWdpc3RlcnMgZGVmaW5lZCBmb3Igbm9kZVxuIik7DQo+ICAg
ICAgPiAtIHJldHVybjsNCj4gICAgICA+ICsgZ290byBvdXRfcHV0Ow0KPiAgICAgID7CoMKg
IH0NCj4gICAgICA+wqDCoCBweGFfaXJxX2Jhc2UgPSBpb19wMnYocmVzLnN0YXJ0KTsNCj4g
ICAgICA+DQo+ICAgICAgPiBAQCAtMjYzLDkgKzI2MywxMiBAQCB2b2lkIF9faW5pdCBweGFf
ZHRfaXJxX2luaXQoaW50ICgqZm4pKHN0cnVjdCBpcnFfZGF0YSAqLCB1bnNpZ25lZCBpbnQp
KQ0KPiAgICAgID7CoMKgIHJldCA9IGlycV9hbGxvY19kZXNjcygtMSwgMCwgcHhhX2ludGVy
bmFsX2lycV9uciwgMCk7DQo+ICAgICAgPsKgwqAgaWYgKHJldCA8IDApIHsNCj4gICAgICA+
wqDCoCBwcl9lcnIoIkZhaWxlZCB0byBhbGxvY2F0ZSBJUlEgbnVtYmVyc1xuIik7DQo+ICAg
ICAgPiAtIHJldHVybjsNCj4gICAgICA+ICsgZ290byBvdXRfcHV0Ow0KPiAgICAgID7CoMKg
IH0NCj4gICAgICA+DQo+ICAgICAgPsKgwqAgcHhhX2luaXRfaXJxX2NvbW1vbihub2RlLCBw
eGFfaW50ZXJuYWxfaXJxX25yLCBmbik7DQo+ICAgICAgPiArDQo+ICAgICAgPiArb3V0X3B1
dDoNCj4gICAgICA+ICsgb2Zfbm9kZV9wdXQobm9kZSk7DQo+ICAgICAgPsKgwqAgfQ0KPiAg
ICAgID7CoMKgICNlbmRpZiAvKiBDT05GSUdfT0YgKi8NCj4gDQo=
