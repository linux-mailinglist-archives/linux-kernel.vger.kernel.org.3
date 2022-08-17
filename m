Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008059678C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbiHQCvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHQCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:51:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8C9A971;
        Tue, 16 Aug 2022 19:51:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so17354285lfu.9;
        Tue, 16 Aug 2022 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=W14zllJWtYlSHh68Ru9N6M/0C/LJ6+LVVbp1T2qLQZ0=;
        b=FK7lxbFEHodLYlUilat/PO8HcSFyh/ZsVfu7VzND71vp1eiT9mcHj+ifALsXT1chuQ
         ZpU030pzBhHieOiyDS7UM/0wUu2kFYH1JliHzyhLRc4/xjvUzOAtNLLutTBzLTASLIDR
         JJ649Vc3cvsVm1RphPxgUxdB2GP6sQyqdW/OXu+AgowDLORKz2OqW765hJbeNQF7N1yu
         IzBiPJL1d3ypgZk3/IaSDeQYj/1uI1NV53quAk3Tp1U5ZTtwr6lZPIFYDpdTvNZtrwjk
         4mMSs/iolTeU0S3NYDd5h1FcneP8ZDrAN9EMiaHRWNEjA/6ErepwCnVkh/zi4jH+03Kx
         XZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=W14zllJWtYlSHh68Ru9N6M/0C/LJ6+LVVbp1T2qLQZ0=;
        b=MdqM43IiA7Yd1AtI0A4XQTT/EFLQQE1dtWEjM7qYM6EGjEqJCjO8FpSeUZdrEpADTH
         E5C7NI16VVK1tdgFm04SbXMKmJlmJnyAhfdM140skaLy1L6T/Oc8/CYHcchZqWQBTyIc
         hFE/ktMNWZYlq8WY9WrQ6h0RQvTWyuKwl8Mi3IQlZwrPmp+dkxyxPtOtrSEyPMxhQUZ0
         DwJNLZ+742yBfuTRVtoxX3NP8+zc9lKa4lV2L4rhr4nFYqUDpWXM5q2zQ4AcEs9X0fEm
         zP3y1CM4h60CbCwZid0b3j/xRmEXrtQS6SRsRJvIhqqAqnqE0QqvkmBbgls8l4C+zqyc
         1/FA==
X-Gm-Message-State: ACgBeo055a8gxbdEFyOoCV/IT6enSBXl+oeWhOkiGzYQ7/cDW+j5zDB9
        fVV1HMB4+TKCbn+qxcWaIAWQCoZ/XPCjoFBnfZsICGo13+zmA6fMHuU=
X-Google-Smtp-Source: AA6agR6ET5E/HYDDji8DHRJ8Dwuz/n1JsRU25ndIVb/jQ9xdfva97kiJE9e7b6rR7sCI4HQJdiQYqHE9hc1Si1Z0Vj0=
X-Received: by 2002:a05:6512:251f:b0:48b:9e9b:353c with SMTP id
 be31-20020a056512251f00b0048b9e9b353cmr7665654lfb.606.1660704708902; Tue, 16
 Aug 2022 19:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220816121907.841-1-lukasz.luba@arm.com>
In-Reply-To: <20220816121907.841-1-lukasz.luba@arm.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 17 Aug 2022 10:51:12 +0800
Message-ID: <CAJy-Am=Krin68+TpCw8Tc3q7z5EfCDbcS_0HqXHj29nhbG5RaA@mail.gmail.com>
Subject: Re: [PATCH] docs: scheduler: Update new path for the sysctl knobs
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMTYsIDIwMjIgYXQgODoxOSBQTSBMdWthc3ogTHViYSA8bHVrYXN6Lmx1YmFA
YXJtLmNvbT4gd3JvdGU6DQo+DQo+IEFkZCBtaXNzaW5nIHVwZGF0ZSBmb3IgdGhlIGRvY3VtZW50
YXRpb24gYml0IG9mIHNvbWUgc2NoZWR1bGVyIGtub2IuDQo+IFRoZSBrbm9icyBoYXZlIGJlZW4g
bW92ZWQgdG8gL2RlYnVnL3NjaGVkLyBsb2NhdGlvbiAod2l0aCBhZGp1c3RlZCBuYW1lcykuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsdWthc3oubHViYUBhcm0uY29tPg0KDQpS
ZXZpZXdlZC1ieTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQoNCj4gLS0tDQo+ICBEb2N1
bWVudGF0aW9uL3NjaGVkdWxlci9zY2hlZC1kZXNpZ24tQ0ZTLnJzdCAgICAgICAgICAgICAgICAg
ICAgfCAyICstDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zY2hlZHVsZXIv
c2NoZWQtZGVzaWduLUNGUy5yc3QgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
c2NoZWR1bGVyL3NjaGVkLWRlc2lnbi1DRlMucnN0IGIvRG9jdW1lbnRhdGlvbi9zY2hlZHVsZXIv
c2NoZWQtZGVzaWduLUNGUy5yc3QNCj4gaW5kZXggNTliMmQxZmI0ZGM0Li4wM2RiNTU1MDQ1MTUg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vc2NoZWR1bGVyL3NjaGVkLWRlc2lnbi1DRlMu
cnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vc2NoZWR1bGVyL3NjaGVkLWRlc2lnbi1DRlMucnN0
DQo+IEBAIC05NCw3ICs5NCw3IEBAIG90aGVyIEhaIGRldGFpbC4gIFRodXMgdGhlIENGUyBzY2hl
ZHVsZXIgaGFzIG5vIG5vdGlvbiBvZiAidGltZXNsaWNlcyIgaW4gdGhlDQo+ICB3YXkgdGhlIHBy
ZXZpb3VzIHNjaGVkdWxlciBoYWQsIGFuZCBoYXMgbm8gaGV1cmlzdGljcyB3aGF0c29ldmVyLiAg
VGhlcmUgaXMNCj4gIG9ubHkgb25lIGNlbnRyYWwgdHVuYWJsZSAoeW91IGhhdmUgdG8gc3dpdGNo
IG9uIENPTkZJR19TQ0hFRF9ERUJVRyk6DQo+DQo+IC0gICAvcHJvYy9zeXMva2VybmVsL3NjaGVk
X21pbl9ncmFudWxhcml0eV9ucw0KPiArICAgL3N5cy9rZXJuZWwvZGVidWcvc2NoZWQvbWluX2dy
YW51bGFyaXR5X25zDQo+DQo+ICB3aGljaCBjYW4gYmUgdXNlZCB0byB0dW5lIHRoZSBzY2hlZHVs
ZXIgZnJvbSAiZGVza3RvcCIgKGkuZS4sIGxvdyBsYXRlbmNpZXMpIHRvDQo+ICAic2VydmVyIiAo
aS5lLiwgZ29vZCBiYXRjaGluZykgd29ya2xvYWRzLiAgSXQgZGVmYXVsdHMgdG8gYSBzZXR0aW5n
IHN1aXRhYmxlDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9zY2hlZHVsZXIvc2NoZWQtZGVzaWduLUNGUy5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy96aF9DTi9zY2hlZHVsZXIvc2NoZWQtZGVzaWduLUNGUy5yc3QNCj4gaW5kZXggMjZiMGYz
NmY3OTNkLi4zMDc2NDAyNDA2YzQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL3poX0NOL3NjaGVkdWxlci9zY2hlZC1kZXNpZ24tQ0ZTLnJzdA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9zY2hlZHVsZXIvc2NoZWQtZGVzaWduLUNGUy5y
c3QNCj4gQEAgLTgwLDcgKzgwLDcgQEAgcC0+c2UudnJ1bnRpbWXjgILkuIDml6ZwLT5zZS52cnVu
dGltZeWPmOW+l+i2s+Wkn+Wkp++8jOWFtuWug+eahOS7u+WKoeWwhuaIkOS4ug0KPiAgQ0ZT5L2/
55So57qz56eS57KS5bqm55qE6K6h5pe277yM5LiN5L6d6LWW5LqO5Lu75L2VamlmZmllc+aIlkha
55qE57uG6IqC44CC5Zug5q2kQ0ZT5bm25LiN5YOP5LmL5YmN55qE6LCD5bqm5Zmo6YKj5qC3DQo+
ICDmnInigJzml7bpl7TniYfigJ3nmoTmpoLlv7XvvIzkuZ/msqHmnInku7vkvZXlkK/lj5HlvI/n
moTorr7orqHjgILllK/kuIDlj6/osIPnmoTlj4LmlbDvvIjkvaDpnIDopoHmiZPlvIBDT05GSUdf
U0NIRURfREVCVUfvvInmmK/vvJoNCj4NCj4gLSAgIC9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfbWlu
X2dyYW51bGFyaXR5X25zDQo+ICsgICAvc3lzL2tlcm5lbC9kZWJ1Zy9zY2hlZC9taW5fZ3JhbnVs
YXJpdHlfbnMNCj4NCj4gIOWug+WPr+S7peeUqOadpeWwhuiwg+W6puWZqOS7juKAnOahjOmdouKA
neaooeW8j++8iOS5n+WwseaYr+S9juaXtuW7tu+8ieiwg+iKguS4uuKAnOacjeWKoeWZqOKAne+8
iOS5n+WwseaYr+mrmOaJueWkhOeQhu+8ieaooeW8j+OAgg0KPiAg5a6D55qE6buY6K6k6K6+572u
5piv6YCC5ZCI5qGM6Z2i55qE5bel5L2c6LSf6L2944CCU0NIRURfQkFUQ0jkuZ/ooqtDRlPosIPl
uqblmajmqKHlnZflpITnkIbjgIINCj4gLS0NCj4gMi4xNy4xDQo+DQo=
