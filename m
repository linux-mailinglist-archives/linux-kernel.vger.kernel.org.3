Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E947515ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380536AbiD3GEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiD3GEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:04:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE0811BA;
        Fri, 29 Apr 2022 23:01:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso3568699pjb.5;
        Fri, 29 Apr 2022 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JYLhkIo1IzRAbscUtCT72q265oaUzzklLgcISSYv7GY=;
        b=KkCAjaKfhCfDY4XLMBg3/PlSe4DbNG3ME0AFMAFS86G4P0NFzzNDdLsVeuvCbS8II0
         U7tFbYT96PmAoJAD+03cdBm2jtM43jiauZFNws0Z3YyUCkZvl6BiLvqSU8OepmvrvWIl
         0WqK9NKUxkEOghLDe6hCtwh1rS3Mt9K+bXnB0iTdUYccTc+KllAEpE99FBH6LTv7GlCp
         JeDYjmwBvZcTZTWPDuWHbTZ83iKIA2gTGWe5beTewk76f7Hwxtx/Ji3hplOM2Z4VO890
         hMg/XU32YIqSUtw2GIIMTgAXOrS5jCSWqbJar6LiYddLwCXEXDPP/BP44o4DYcrE47ur
         5cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JYLhkIo1IzRAbscUtCT72q265oaUzzklLgcISSYv7GY=;
        b=t5cFRhdos92eXUBJZaU0l0dsO00XFGeioaLo8aCruVqN6oVlVwoPxU/f6CBTFgVr5F
         atC2kN6mWsozybxNpt2agRa3S3Hi8U+rwlXMHhvCWKKsYqnyr8MSf0VPv4lToiLDEprz
         94gneXYhtYH0VOUwNDyCHnW6rvTwFJrZYr1mlcgoUYd8gIZLzTfnJbEnmZx86CXeXIoE
         Q6Z6TKisQNJQz8juY3rStuK9oYwVfUpfTDY3YgbBh2fHGk3bxART98yDyv3ia24JtSrA
         Lb9xRKz+ijrBeMtzn5miUbeo9DvFQgs5n1Yk20BVx/Zh9s11kjtH22how9Ir3Qpnexv6
         ND6Q==
X-Gm-Message-State: AOAM531m5Iq/GVPn54fLw1zWCRBQ9S1coLm+qbP0ObeuvHUpFrq7naDF
        5Cwacnjnt4N0pzYJTzv1yimVd3cBmOk=
X-Google-Smtp-Source: ABdhPJzjrg6/BkhjrhCmAhrJGYkHnx8OMw6SbLv0uWKfLkwGChsyNDYlB4vHsL4yTJKd7buWIdFmGQ==
X-Received: by 2002:a17:90b:350e:b0:1d2:b6e2:1000 with SMTP id ls14-20020a17090b350e00b001d2b6e21000mr2785395pjb.199.1651298474775;
        Fri, 29 Apr 2022 23:01:14 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902bf4700b0015e8d4eb272sm595857pls.188.2022.04.29.23.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 23:01:14 -0700 (PDT)
Message-ID: <475af784-ae64-1a8c-6e81-cf64cf3079b8@gmail.com>
Date:   Sat, 30 Apr 2022 15:01:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] docs/trans/ja_JP/howto: Don't mention specific kernel
 versions
Content-Language: en-US
To:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     corbet@lwn.net, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429230001.6124-1-fujimotokosuke0@gmail.com>
 <CAO+cJp0T-OrC1x+pTezPqWdkOKcSXutLF6yb=YO7TCVMh7BxwQ@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <CAO+cJp0T-OrC1x+pTezPqWdkOKcSXutLF6yb=YO7TCVMh7BxwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAzMCBBcHIgMjAyMiAxNDo0NDozMyArMDkwMCwNClRzdWdpa2F6dSBTaGliYXRh
IHdyb3RlOg0KPiBIZWxsbyBGdWppbW90by1zYW4sDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBw
YXRjaC4NCj4gVW5mb3J0dW5hdGVseSwgSSBmb3VuZCBvbmUgbW9yZSBpc3N1ZS4uDQo+IA0K
PiBPbiBTYXQsIEFwciAzMCwgMjAyMiBhdCA4OjAwIEFNIEtvc3VrZSBGdWppbW90bw0KPiA8
ZnVqaW1vdG9rb3N1a2UwQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhpcyBjaGFuZ2Ug
aXMgYmFzZWQgb24gY29tbWl0IGQyYjAwOGYxMzRiNw0KPj4gKCJEb2N1bWVudGF0aW9uL3By
b2Nlc3MvaG93dG86IFVwZGF0ZSBmb3IgNC54IC0+IDUueCB2ZXJzaW9uaW5nIikuDQo+Pg0K
Pj4gUmVwbGFjZSAiNC54IGtlcm5lbCB2ZXJzaW9uIiB3aXRoIGdlbmVyaWMgdGVybSBzdWNo
IGFzICJtYWlubGluZSB0cmVlIg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtvc3VrZSBGdWpp
bW90byA8ZnVqaW1vdG9rb3N1a2UwQGdtYWlsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBa2ly
YSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4gVjI6IFJlZm9ybWF0
dGVkIGNvbW1pdCBsb2cgbWVzc2FnYWUgKFlva29zYXdhLXNhbikNCj4+IFYzOiBVcGRhdGVk
IHNvbWUgZXhwcmVzc2lvbnMgKFNoaWJhdGEtc2FuKQ0KPj4gLSBhZGRlZCAidmVyc2lvbiBu
dW1iZXIiIGluIG1haW5saW5lIHRyZWUgc2VjdGlvbg0KPj4gLSB1cGRhdGVkIGZyb20gInN0
YWJsZSBrZXJuZWwiIHRvICJzdGFibGUgdHJlZSINCj4+IFY0OiBBZGRlZCByZXZpZXdlZCBi
eSB0YWcgYW5kIHJlbW92ZWQgZXh0cmEgY2hhcmFjdGVycyAoWW9rb3Nhd2Etc2FuKQ0KPj4g
LS0tDQo+PiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IHwg
NDQgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IGIvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+PiBpbmRleCBkNjY3ZjlkOGEwMmEuLmRl
YWM0MWViMDM4YSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L2phX0pQL2hvd3RvLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
amFfSlAvaG93dG8ucnN0DQpbLi4uXQ0KPj4NCj4+IC3jgZPjga7jgoTjgormlrnjgavjgojj
gaPjgabjgIEtbmV4dCDjgqvjg7zjg43jg6vjga/mrKHjga7jg57jg7zjgrjmqZ/kvJrjgafj
ganjgpPjgarjgoLjga7jgYzjg6HjgqTjg7MNCj4+IC3jg6njgqTjg7Pjgqvjg7zjg43jg6vj
gavjg57jg7zjgrjjgZXjgozjgovjgYvjgIHjgYrjgYrjgb7jgYvjgarjga7lsZXmnJvjgpLm
j5DkvpvjgZfjgb7jgZnjgIItbmV4dCDjgqvjg7wNCj4+IC3jg43jg6vjga7lrp/ooYzjg4bj
grnjg4jjgpLooYzjgYblhpLpmbrlpb3jgY3jgarjg4bjgrnjgr/jg7zjga/lpKfjgYTjgavm
rZPov47jgZXjgozjgb7jgZnjgIINCj4+ICvjgZPjga7jgoTjgormlrnjgavjgojjgaPjgabj
gIFsaW51eC1uZXh0IOOBr+asoeOBruODnuODvOOCuOapn+S8muOBp+OBqeOCk+OBquOCguOB
ruOBjOODoeOCpOODsw0KPj4gK+ODqeOCpOODs+OBq+ODnuODvOOCuOOBleOCjOOCi+OBi+OA
geOBiuOBiuOBvuOBi+OBquOBruWxleacm+OCkuaPkOS+m+OBl+OBvuOBmeOAgg0KPiANCj4g
VGhpcyB3b3VsZCBiZToNCj4g44Op44Kk44Oz44Gr44Oe44O844K444GV44KM44KL44GL44CB
44GK44GK44G+44GL44Gq5bGV5pyb44KS5o+Q5L6b44GX44G+44GZ44CCDQoNCkdvb2QgZXll
cyENCkknbSBiZWdpbm5pbmcgdG8gdGhpbmsgSSBjYW4ndCBiZSBhIGdvb2QgcmV2aWV3ZXIu
Li4gIDotLw0KDQpGdWppbW90by1zYW4sIHBsZWFzZSBrZWVwIG15IFJldmlld2VkLWJ5OiB0
YWcgaW4gdjUuDQpBcyBTaGliYXRhLXNhbiBtaWdodCBjYXRjaCBzb21ldGhpbmcgZWxzZSwg
djUgY2FuIHdhaXQgZm9yIGEgZGF5DQpvciBzbywgSSBndWVzcy4NCg0KICAgICAgICBUaGFu
a3MsIEFraXJhDQoNCj4gDQo+IFRoYW5rIHlvdSBmb3IgZml4aW5nIHRoaXMgZG9jdW1lbnQu
DQo+IA0KPiBUc3VnaWthenUgU2hpYmF0YQ0K
