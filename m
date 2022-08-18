Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F4598731
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiHRPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiHRPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:13:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E1BBFC4F;
        Thu, 18 Aug 2022 08:12:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso1462651pjd.1;
        Thu, 18 Aug 2022 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=HoB1mr6IWfBGHZ6FdXCQxnBFpPL/QtyF9KhhKRjqSlA=;
        b=FckyB/OB5W0zFD594895a04QkrbgceydPqstaNMmeygoQy9S2PccZU6yQaaeTJ1/CH
         7fAdxPKvYiXDQiQQagb2GiMUa5ty6yo6qJRsaRmoae1V52++fyR7f/s/Yn/r+tP7w/On
         fgNyEp0rydmQrIPK5nhtKA6R+N9PgAloT12NrJXu9cZ8yXzGkZ6/Mk8sOyuOtDzeJiP8
         QZa8XCnFFRPEAAes2ROJVEa9OXwwgSdsfI6Nng/as8l87X1kNFnX0Yh7fn/dLEUK7eHz
         EDf/QXpMHBEGc33zVlKK5Nv9K/LRm0erwG6bRcBKZOSXW/xEmbYqBiq/WLx+cb9lm4o/
         pU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=HoB1mr6IWfBGHZ6FdXCQxnBFpPL/QtyF9KhhKRjqSlA=;
        b=zN0GX7fFbKKYr3CR6qs0mIVft1z4+DF7jec36fmkLzWmGDWieuyaSBJFBiCX6kfxOQ
         NyPeY5ugv8UaxRxmzTMumfSeL6TnmjbQreffgbXDNVG/LOwsVEvERrrQcXDzaqRKKO6c
         tZPTFRGQUATh3sYV76FVY2iYOYWeNWr7X3EImXHbgEoLKlE0HrPSqTC7lueb5i0nSZ6u
         l/phU1VgtZpuWhl4abvdImEEQ/VnPgpMb8o3jsIqtkP+UT7gd/U9qTtg3s3g0L4sVmCY
         qFNd2cF/sDpulBzjRf0x/CszPf6JmUYxMPkHwZZHCDyPEeXhwFEzXKTcYaaCUoo+vcwB
         CiUw==
X-Gm-Message-State: ACgBeo2mZi06F+DHDDaFZQ1x0gqj+BO5hzyAeoeDCRNDy22VyqEavMFh
        FhSfgXBGPu685J+NI9xbMkA=
X-Google-Smtp-Source: AA6agR6HAJtQsNeiv008LJGLVrV4q07orrsYWQA6AzovC5ISlm6xeKw58wl2nXoSOrPx293Qn8Mo2g==
X-Received: by 2002:a17:90b:4b4f:b0:1f3:19ed:37b5 with SMTP id mi15-20020a17090b4b4f00b001f319ed37b5mr9061690pjb.108.1660835558535;
        Thu, 18 Aug 2022 08:12:38 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g7-20020aa79f07000000b0052dcbd87ae8sm1746656pfr.25.2022.08.18.08.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:12:37 -0700 (PDT)
Message-ID: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
Date:   Fri, 19 Aug 2022 00:12:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/ja_JP/SubmittingPatches: Remove reference to
 submitting-drivers.rst
Content-Type: text/plain; charset=UTF-8
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

UmVmbGVjdCBjaGFuZ2VzIG1hZGUgaW4gY29tbWl0IDlkYjM3MGRlMjc4MCAoImRvY3M6IHBy
b2Nlc3M6IHJlbW92ZQ0Kb3V0ZGF0ZWQgc3VibWl0dGluZy1kcml2ZXJzLnJzdCIpDQoNClJl
cG9ydGVkLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4N
ClNpZ25lZC1vZmYtYnk6IEFraXJhIFlva29zYXdhIDxha2l5a3NAZ21haWwuY29tPg0KRml4
ZXM6IDlkYjM3MGRlMjc4MCAoImRvY3M6IHByb2Nlc3M6IHJlbW92ZSBvdXRkYXRlZCBzdWJt
aXR0aW5nLWRyaXZlcnMucnN0IikNCkNjOiBUc3VnaWthenUgU2hpYmF0YSA8c2hpYmF0YUBs
aW51eGZvdW5kYXRpb24ub3JnPg0KLS0tDQpIaSwNCg0KVGhpcyBpcyBhIGJhbmQtYWlkZSBw
YXRjaCByZW1vdmluZyBhIHNlbnRlbmNlIHdpdGggcmVmZXJlbmNlIHRvDQpzdWJtaXR0aW5n
LWRyaXZlcnMucnN0IChyZW1vdmVkIGR1cmluZyB0aGUgdjYuMCBtZXJnZSB3aW5kb3cpLg0K
DQpBcyB0aGUgdHJhbnNsYXRpb24gYXJvdW5kIGhlcmUgaXMgb3V0ZGF0ZWQsIHRoZSBlbmQg
cmVzdWx0IGRvZXMNCm5vdCBtYXRjaCB0aGUgY29ycmVzcG9uZGluZyB0ZXh0IGluIHRoZSBF
bmdsaXNoIGRvYy4NCg0KUmVtYWluaW5nIGRpc2NyZXBhbmNpZXMgd2lsbCBiZSB0YWtlbiBj
YXJlIG9mIHdoaWxlIGNhdGNoaW5nDQp1cCB0aGUgb3RoZXIgY2hhbmdlcyBvZiB0aGUgb3Jp
Z2luYWwgZG9jLg0KDQogICAgICAgIFRoYW5rcywgQWtpcmENCi0tDQogRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvamFfSlAvU3VibWl0dGluZ1BhdGNoZXMgfCAzICstLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL1N1Ym1pdHRpbmdQYXRjaGVz
IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvU3VibWl0dGluZ1BhdGNoZXMN
CmluZGV4IDY2Y2UwZDhiMDUyNi4uMDRkZWI3N2IyMGM2IDEwMDY0NA0KLS0tIGEvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvU3VibWl0dGluZ1BhdGNoZXMNCisrKyBiL0Rv
Y3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL1N1Ym1pdHRpbmdQYXRjaGVzDQpAQCAt
MzUsOCArMzUsNyBAQCBMaW51eCDjgqvjg7zjg43jg6vjgavlpInmm7TjgpLliqDjgYjjgZ/j
gYTjgajmgJ3jgaPjgabjgYTjgovlgIvkurrlj4jjga/kvJrnpL4NCiDjgabjgoLjgonjgYjj
goTjgZnjgY/jgZnjgovmj5DmoYjjgpLpm4bjgoHjgZ/jgoLjga7jgafjgZnjgIINCiANCiDj
grPjg7zjg4njgpLmipXnqL/jgZnjgovliY3jgavjgIFEb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
c3VibWl0LWNoZWNrbGlzdC5yc3Qg44Gu6aCF55uu44Oq44K544OI44Gr55uuDQot44KS6YCa
44GX44Gm44OB44Kn44OD44Kv44GX44Gm44GP44Gg44GV44GE44CC44KC44GX44GC44Gq44Gf
44GM44OJ44Op44Kk44OQ44O844KS5oqV56i/44GX44KI44GG44Go44GXDQot44Gm44GE44KL
44Gq44KJ44CBRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctZHJpdmVycy5yc3Qg
44Gr44KC55uu44KS6YCa44GX44Gm44GP44Gg44GV44GE44CCDQor44KS6YCa44GX44Gm44OB
44Kn44OD44Kv44GX44Gm44GP44Gg44GV44GE44CCDQogDQogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiDjgrvjgq/jgrfjg6fjg7MxIOODkeODg+OD
geOBruS9nOOCiuaWueOBqOmAgeOCiuaWuQ0KDQpiYXNlLWNvbW1pdDogMzM5MTcwZDhkM2Rh
NTY4NTc2MjYxOTA4MDI2M2FiYjc4NzAwYWI0Yw0KLS0gDQoyLjI1LjENCg0K
