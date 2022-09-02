Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC15AA9F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiIBI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiIBI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:28:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38051A2DB9;
        Fri,  2 Sep 2022 01:28:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so2267461lfr.2;
        Fri, 02 Sep 2022 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=opRGhrIs3n7jb7ROo4sypmxZSciZpsuGWorQ3lNduHk=;
        b=mpnlFPTfY0jIYFG2era/324D1pL7w83PFX+gDfzRNlmBw9L97B8lJSzKMQ3F9sz8kS
         cFFqQbvhWTkoxj//GUtD59jJw7rNECywIUFSlUj4/aI00pDCIt3VHtT2g6OV50oDaZ3Z
         UpM4Xkzp3ciiE5MmR5K2GFS/0IlOcUU+jaxmc+kyGoDaDQAIaHecgtXMrpnAH521lfJK
         dZpOgivEA9WEdp4ISrOJJli02/seFNND+ssxiRV9ns2CkAmh/uBX41svkx2WA7YtstWj
         8DIaKmfgwR4L/3pMtLUr8JjEUnPlmMUT7pe7rVcUBYIC1gF0aTPuZjntWdHy+mRZz/O+
         rGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=opRGhrIs3n7jb7ROo4sypmxZSciZpsuGWorQ3lNduHk=;
        b=lhPxArTaP6iO8V1jNnSGebd2/uYSuDEqFAsVSk363O71OLj5JvqdDUJWH2LaJ/uyXH
         t7H+B9HOXKmBsVo50x/sDLwgklMUKHr2fh5uYP8JHdSYip8hLhkmtzR3grKIN7GlsQgV
         b4A6gn6dUMTyAflIPWvHWl0OB+cf/A7Ftqi1eds889uZ0IuO/k51E2YDTPEsSukclnob
         sgeMA4kZ6hhMQm0yDOeZKzDLcqgDI6rFhdE297RGkoyBantaiG5z8dFjxYcfkDtBXanN
         1z2zqbaRpPwY9nUxKfMdfzIY3HOu7WG7DG3xv/dJ3+1xCHoLkk9o16N2kknUR0SrJlvM
         2/DQ==
X-Gm-Message-State: ACgBeo188icDGBiWKAIwBwX7eCiegyDeJvv1LLaplBmKjJ4ysn8hZLiG
        ZA1KNXHOvdlz1Ypkz2X2nTj9fcqhUYQPmZvYASo=
X-Google-Smtp-Source: AA6agR54eq1V2yKXHNCNnLKLBW6tVZbCgT+d+saY/E6rAQL3DkTpV059eKg2GCHxqPKpXw6O6JcXLpfNhoHrM4k9Png=
X-Received: by 2002:a19:5e01:0:b0:492:c03a:aa8e with SMTP id
 s1-20020a195e01000000b00492c03aaa8emr12996258lfb.139.1662107295496; Fri, 02
 Sep 2022 01:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
In-Reply-To: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 2 Sep 2022 16:27:39 +0800
Message-ID: <CAJy-AmnOwM+CMu-8PaAvXfq2h==vrAX08=aJktHjUYXkjxh0FQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/zh_CN: add latest kmap_local_page translation
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBTZXAgMiwgMjAyMiBhdCA0OjA4IFBNIFpoYW8gTGl1IDx6aGFvMS5saXVAbGludXgu
aW50ZWwuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogWmhhbyBMaXUgPHpoYW8xLmxpdUBpbnRlbC5j
b20+DQo+DQo+IFRyYW5zbGF0ZSB0aGUgbGFzdGVzdCBkZXNjcmlwdGlvbiBvZiBrbWFwX2xvY2Fs
X3BhZ2UgaW50byBDaGluZXNlLg0KPg0KPiBUaGUgdHJhbnNsYXRpb24gaXMgYmFzZWQgb24gdGhl
c2UgY29tbWl0czoNCj4NCj4gY29tbWl0IDUxNmVhMDQ2ZWM1NTUgKCJEb2N1bWVudGF0aW9uL21t
OiBkb24ndCBrbWFwKigpIHBhZ2VzIHdoaWNoDQo+IGNhbid0IGNvbWUgZnJvbSBISUdITUVNIikN
Cj4NCj4gY29tbWl0IDZiM2FmZTJlZWVjMjcgKCJEb2N1bWVudGF0aW9uL21tOiBhdm9pZCBpbnZh
bGlkIHVzZSBvZg0KPiBhZGRyZXNzZXMgZnJvbSBrbWFwX2xvY2FsX3BhZ2UoKSIpDQo+DQo+IGNv
bW1pdCA4NGI4NmY2MDU0YzQyICgiRG9jdW1lbnRhdGlvbi9tbTogcnJlZmVyIGttYXBfbG9jYWxf
cGFnZSgpDQo+IGFuZCBhdm9pZCBrbWFwKCkiKQ0KPg0KPiBjb21taXQgYTllOWM5Mzk2NmFmZCAo
IkRvY3VtZW50YXRpb24vbW06IGFkZCBkZXRhaWxzIGFib3V0DQo+IGttYXBfbG9jYWxfcGFnZSgp
IGFuZCBwcmVlbXB0aW9uIikNCj4NCj4gU3VnZ2VzdGVkLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlu
eUBpbnRlbC5jb20+DQo+IFN1Z2dlc3RlZC1ieTogRmFiaW8gTS4gRGUgRnJhbmNlc2NvIDxmbWRl
ZnJhbmNlc2NvQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmhhbyBMaXUgPHpoYW8xLmxp
dUBpbnRlbC5jb20+DQoNCkdvb2Qgam9i77yBDQpSZXZpZXdlZC1ieTogQWxleCBTaGkgPGFsZXhz
QGtlcm5lbC5vcmc+DQoNCj4gLS0tDQo+IFN1Z2dlc3RlZCBieSBjcmVkaXRzLg0KPiAgICAgICAg
IElyYTogUmVmZXJyZWQgdG8gaGlzIHRhc2sgZG9jdW1lbnQuDQo+ICAgICAgICAgRmFiaW86IFJl
ZmVycmVkIHRvIGhpcyB3b3JrIG9uIHRoZSBvcmlnaW5hbCBFbmdsaXNoIGRvY3VtZW50Lg0KPg0K
PiAtLS0NCj4gIC4uLi90cmFuc2xhdGlvbnMvemhfQ04vbW0vaGlnaG1lbS5yc3QgICAgICAgICB8
IDIwICsrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vbW0vaGlnaG1lbS5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9tbS9oaWdobWVtLnJzdA0KPiBpbmRleCBmNzQ4MDBhNmQ5YTcuLmFjNGM4NmVkNzRk
OCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0vaGln
aG1lbS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vbW0vaGln
aG1lbS5yc3QNCj4gQEAgLTU4LDE0ICs1OCwyOCBAQA0KPiAgICDlnKjlj6/ooYznmoTmg4XlhrXk
uIvvvIzov5nkuKrlh73mlbDlupTor6Xmr5Tlhbbku5bmiYDmnInnmoTlh73mlbDkvJjlhYjkvb/n
lKjjgIINCj4NCj4gICAg6L+Z5Lqb5pig5bCE5piv57q/56iL5pys5Zyw5ZKMQ1BV5pys5Zyw55qE
77yM6L+Z5oSP5ZGz552A5pig5bCE5Y+q6IO95LuO6L+Z5Liq57q/56iL5Lit6K6/6Zeu77yM5bm2
5LiU5b2T5pig5bCE5aSE5LqO5rS75Yqo54q2DQo+IC0gIOaAgeaXtu+8jOivpee6v+eoi+S4jkNQ
Vee7keWumuOAguWNs+S9v+e6v+eoi+iiq+aKouWNoOS6hu+8iOWboOS4uuaKouWNoOawuOi/nOS4
jeS8muiiq+WHveaVsOemgeeUqO+8ie+8jENQVeS5n+S4jeiDvemAmui/hw0KPiAtICBDUFUtaG90
cGx1Z+S7juezu+e7n+S4reaLlOWHuu+8jOebtOWIsOaYoOWwhOiiq+WkhOeQhuaOieOAgg0KPiAr
ICDmgIHml7bvvIzor6Xnur/nqIvkuI5DUFXnu5HlrprjgILljbPkvb/miqLljaDmsLjov5zkuI3k
vJrooqvov5nkuKrlh73mlbDnpoHnlKjvvIxDUFXkuZ/kuI3og73pgJrov4dDUFUtaG90cGx1Z+S7
juezuw0KPiArICDnu5/kuK3mi5Tlh7rvvIznm7TliLDmmKDlsITooqvlpITnkIbmjonjgIINCj4N
Cj4gLSAg5Zyo5pys5Zyw55qEa21hcOWMuuWfn+S4remHh+WPlnBhZ2VmYXVsdHPmmK/mnInmlYjn
moTvvIzpmaTpnZ7ojrflj5bmnKzlnLDmmKDlsITnmoTkuIrkuIvmlofnlLHkuo7lhbbku5bljp/l
m6DkuI3lhYHorrgNCj4gKyAg5Zyo5pys5Zyw55qEa21hcOWMuuWfn+S4reiOt+WPlnBhZ2VmYXVs
dHPmmK/mnInmlYjnmoTvvIzpmaTpnZ7ojrflj5bmnKzlnLDmmKDlsITnmoTkuIrkuIvmlofnlLHk
uo7lhbbku5bljp/lm6DkuI3lhYHorrgNCj4gICAg6L+Z5qC35YGa44CCDQo+DQo+ICsgIOWmguWJ
jeaJgOi/sO+8jHBhZ2VmYXVsdOWSjOaKouWNoOawuOi/nOS4jeS8muiiq+emgeeUqOOAguS4jemc
gOimgeemgeeUqOaKouWNoO+8jOWboOS4uuW9k+S4iuS4i+aWh+WIh+aNouWIsOS4jeWQjOeahOS7
u+WKoQ0KPiArICDml7bvvIzkvKDlh7rku7vliqHnmoTmmKDlsITkvJrooqvkv53lrZjvvIzogIzk
vKDlhaXku7vliqHnmoTmmKDlsITkvJrooqvmgaLlpI3jgIINCj4gKw0KPiAgICBrbWFwX2xvY2Fs
X3BhZ2UoKeaAu+aYr+i/lOWbnuS4gOS4quacieaViOeahOiZmuaLn+WcsOWdgO+8jOW5tuS4lOWB
h+Wummt1bm1hcF9sb2NhbCgp5LiN5Lya5aSx6LSl44CCDQo+DQo+ICsgIOWcqENPTkZJR19ISUdI
TUVNPW7lhoXmoLjlkozkvY7lhoXlrZjpobXpnaLkuIrvvIzov5nlsIbov5Tlm57nm7TmjqXmmKDl
sITnmoTomZrmi5/lnLDlnYDjgILlj6rmnInnnJ/mraPnmoTpq5jlhoXlrZjpobUNCj4gKyAg6Z2i
5Lya6KKr5Li05pe25pig5bCE44CC5Zug5q2k77yM55So5oi35Y+v5Lul5Li65bey55+l5LiN5piv
5p2l6IeqWk9ORV9ISUdITUVN55qE6aG16Z2i6LCD55So5pmu6YCa55qEDQo+ICsgIHBhZ2VfYWRk
cmVzcygp77yM5L2G5piv77yM5L2/55Soa21hcF9sb2NhbF9wYWdlKCkgLyBrdW5tYXBfbG9jYWwo
KeaAu+aYr+WuieWFqOeahOOAgg0KPiArDQo+ICsgIOiZveeEtuWug+avlGttYXAoKeW/q+W+l+Wk
mu+8jOS9huWvueS6jumrmOWGheWtmOaDheWGte+8jOWug+W4puacieaMh+mSiOacieaViOaAp+ea
hOmZkOWItuOAguWSjGttYXAoKeaYoOWwhOebuOWPje+8jOacrOWcsA0KPiArICDmmKDlsITku4Xl
nKjosIPnlKjogIXnmoTkuIrkuIvmlofkuK3mnInmlYjvvIzlubbkuI3og73ooqvkuqTnu5nlhbbk
u5bnmoTkuIrkuIvmlofjgILov5nmhI/lkbPnnYDnlKjmiLflv4Xpobvnu53lr7nnoa7kv53ov5Tl
m57nmoTlnLDlnYANCj4gKyAg5LuF5Zyo5pig5bCE5a6D55qE57q/56iL55qE5pys5Zyw5L2/55So
44CCDQo+ICsNCj4gKyAg5aSn5aSa5pWw5Luj56CB5Y+v5Lul6K6+6K6h5Li65L2/55So57q/56iL
5pys5Zyw5pig5bCE44CC5Zug5q2k77yM55So5oi35bqU6K+l5bCd6K+V6L+Z5qC35Y676K6+6K6h
5LuW5Lus55qE5Luj56CB77yM5Zyo5Zyw5Z2A5Lya6KKr5L2/DQo+ICsgIOeUqOeahOWQjOS4gOe6
v+eoi+S4reaYoOWwhOmhtemdouadpemBv+WFjeS9v+eUqGttYXAoKe+8jOW5tuS4lOabtOWAvuWQ
keS6juWOu+S9v+eUqGttYXBfbG9jYWxfcGFnZSgp44CCDQo+ICsNCj4gICAg5bWM5aWXa21hcF9s
b2NhbF9wYWdlKCnlkoxrbWFwX2F0b21pYygp5pig5bCE5Zyo5LiA5a6a56iL5bqm5LiK5piv5YWB
6K6455qE77yI5pyA5aSa5YiwS01BUF9UWVBFX05S77yJ77yMDQo+ICAgIOS9huaYr+Wug+S7rOea
hOiwg+eUqOW/hemhu+S4peagvOaOkuW6j++8jOWboOS4uuaYoOWwhOeahOWunueOsOaYr+WfuuS6
juWghuagiOeahOOAguWFs+S6juWmguS9leeuoeeQhuW1jOWll+aYoOWwhOeahOe7huiKgu+8jA0K
PiAgICDor7flj4Lop4FrbWFwX2xvY2FsX3BhZ2UoKSBrZG9jc++8iOWMheWQq+WcqCAi5Ye95pWw
ICLpg6jliIbvvInjgIINCj4gLS0NCj4gMi4zNC4xDQo+DQo=
