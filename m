Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9048AE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiAKNBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbiAKNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:01:18 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69BC06173F;
        Tue, 11 Jan 2022 05:01:18 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s6so22334920ioj.0;
        Tue, 11 Jan 2022 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wvHcXYfEUweUoTqnNl+L4GmE26DEMDCn3xKAlXr2Ptw=;
        b=e58+6sDg9cYTMmVQUfW/d+LnW9OBztu7eFsF/Z7vMb3gGfcyX0zw0OiW9Q3Qs4+lX6
         Q5oAduuPRlAjWv1V9L8SKpaqYHhnH00U8mdhig5YOJRFYCOU2IwLGg7TKwy7JBVBgsTO
         F4MDAXTIAlN9395rJ8xF2Mrwn1/B5iogdE7+UdTV4zLJLmsP0qBPC5QuPTiAv3DLEzfn
         2r63ztksq4pY4fsOJ05x/dZrwK4FvY9YvCv0sFG7WINZms0d16lOQ5gqrwRp5q821v3u
         Ij4vBNubfam7ISqDK7NO2DDA0x7G4pd8t0+PR0lRL7Yo4t3Vm4CJX8Wh040cuHdyQNUJ
         OlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wvHcXYfEUweUoTqnNl+L4GmE26DEMDCn3xKAlXr2Ptw=;
        b=oMZ2qgPJhH8FtXPpoD2aj3GJFaYe48KofKQhURfCzt/2IQ4NHdtio0aWX7fOOITjUx
         JYGV7cEdSpk67GV8bvRM8IsE/hqElEWc82kD/T+Pv2nCSnuF9mn5hi22/hnjBr/v0ldG
         kCC9h63dfddrQ2QIk2CQyVy8+jJRh/Mz1xW/XFopwEZBSTmEVVrBFhoZqiw+O3bt13h1
         fbWqwnPg34s+S1CaS+O64hcHCwkstTFp5fXRKsMHK8TpsansC1NgmGtYoyVrsVkLPPRy
         HwCUV9hoOUSAYqDr9uo8mQQETbbuPfqoTIMlqFXWSFZeNIQrNac3H9hOWcDVIry+KJ5v
         e50g==
X-Gm-Message-State: AOAM531ynth+Ujy39WfQBW5luUuP7U1pnNAVlpUEGngO9yUZegYlG53m
        JmDfMYa5ADoON7OnlHoRba64Rn+TSBqOklRYwgU=
X-Google-Smtp-Source: ABdhPJx0mAMfjAuIsp88sVTRBJnA6sF+BpHxQRidnazhdeHGdHcpKkTRJM8S1AOJkiWs/k9QCtthCpDFE9LmGswUWdc=
X-Received: by 2002:a02:bb8f:: with SMTP id g15mr2314067jan.40.1641906077575;
 Tue, 11 Jan 2022 05:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20220110122929.647573-1-xu.xin16@zte.com.cn> <20220110123307.647802-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220110123307.647802-1-xu.xin16@zte.com.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Tue, 11 Jan 2022 21:00:41 +0800
Message-ID: <CAJy-Amn71P3T3Bt1wNSQ3eXi2B3R_F_KGZziRmMKDPg0+RSM8Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs/zh_CN: Add zh_CN/vm/ksm.rst
To:     CGEL <cgel.zte@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, xu.xin16@zte.com.cn,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgODozMyBQTSA8Y2dlbC56dGVAZ21haWwuY29tPiB3cm90
ZToNCj4NCj4gRnJvbTogeHUgeGluIDx4dS54aW4xNkB6dGUuY29tLmNuPg0KPg0KPiBUaGlzIGFk
ZCB6aF9DTi92bS9rc20ucnN0Lg0KPg0KPiBSZXBvcnRlZC1ieTogWmVhbCBSb2JvdCA8emVhbGNp
QHp0ZS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IHh1IHhpbiA8eHUueGluMTZAenRlLmNvbS5j
bj4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi92bS9rc20ucnN0
IHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
NyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vdm0va3NtLnJzdA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvemhfQ04vdm0va3NtLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL3ZtL2tzbS5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMC4uOTUyMDg5Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL3ZtL2tzbS5yc3QNCj4gQEAgLTAsMCArMSw3NyBAQA0KPiArLi4gaW5j
bHVkZTo6IC4uL2Rpc2NsYWltZXItemhfQ04ucnN0DQo+ICsNCj4gKzrljp/mlodPcmlnaW5hbDog
ICAgRG9jdW1lbnRhdGlvbi92bS9rc20ucnN0DQo+ICsNCj4gKzror5HogIVUcmFuc2xhdG9yOiAg
5b6Q6ZGrIHh1IHhpbiA8eHUueGluMTZAenRlLmNvbS5jbj4NCj4gKw0KPiArOuagoeivkVByb29m
cmVhZGVyOiDmnajmtIsgWWFuZyBZYW5nIDx5YW5nLnlhbmcyOUB6dGUuY29tLmNuPg0KPiArDQo+
ICsuLiBfa3NtOg0KDQpEdXBsaWNhdGUgaW5mbywgYmV0dGVyIHRvIHJlbW92ZS4NCg0KPiArDQo+
ICs9PT09PT09PT09PT0NCj4gK+WGheaguOWQjOmhteWQiOW5tg0KPiArPT09PT09PT09PT09DQo+
ICsNCj4gK0tTTSDmmK/kuIDnp43oioLnnIHlhoXlrZjnmoTmlbDmja7ljrvph43lip/og73vvIzn
lLFDT05GSUdfS1NNPXnlkK/nlKjvvIzlubblnKgyLjYuMzLniYjmnKzml7booqvmt7vliqANCj4g
K+WIsExpbnV45YaF5qC444CC6K+m6KeBIGBgbW0va3NtLmNgYCDnmoTlrp7njrDvvIzku6Xlj4po
dHRwOi8vbHduLm5ldC9BcnRpY2xlcy8zMDY3MDTlkowNCj4gK2h0dHBzOi8vbHduLm5ldC9BcnRp
Y2xlcy8zMzA1ODkNCj4gKw0KPiArS1NN55qE55So5oi356m66Ze055qE5o6l5Y+j5ZyoIGBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2tzbS5yc3QgPGFkbWluX2d1aWRlX2tzbT5gDQo+ICvm
lofmoaPkuK3mnInmj4/ov7DjgIINCj4gKw0KPiAr6K6+6K6hDQo+ICs9PT09DQo+ICsNCj4gK+am
gui/sA0KPiArLS0tLQ0KPiArDQo+ICsuLiBrZXJuZWwtZG9jOjogbW0va3NtLmMNCj4gKyAgIDpE
T0M6IE92ZXJ2aWV3DQoNCnJlbW92ZSBhYm92ZSAyIGxpbmVzLCBjaGVjayB0aGUgY29yZS1hcGkg
dHJhbnNsYXRpb24gZm9yIHJlZmVyZW5jZS4NCg0KPiArDQo+ICvpgIbmmKANCj4gKy0tLS0tLQ0K
PiArS1NN57u05oqk552A56iz5a6a5qCR5Lit55qES1NN6aG155qE6YCG5pig5bCE5L+h5oGv44CC
DQo+ICsNCj4gK+W9k0tTTemhtemdoueahOWFseS6q+aVsOWwj+S6jiBgYG1heF9wYWdlX3NoYXJp
bmdgYCDnmoTomZrmi5/lhoXlrZjljLrln58oVk1Bcynml7bvvIzliJnku6PooajkuoYNCj4gK0tT
TemhteeahOeos+WumuagkeWFtuS4reeahOiKgueCueaMh+WQkeS6huS4gOS4qnJtYXBfaXRlbee7
k+aehOS9k+exu+Wei+eahOWIl+ihqOOAguWQjOaXtu+8jOi/meS4qktTTemhtQ0KPiAr55qEIGBg
cGFnZS0+bWFwcGluZ2BgIOaMh+WQkeS6huivpeeos+WumuagkeiKgueCueOAgg0KPiArDQo+ICvl
poLmnpzlhbHkuqvmlbDotoXov4fkuobpmIjlgLzvvIxLU03lsIbnu5nnqLPlrprmoJHmt7vliqDn
rKzkuozkuKrnu7TluqbjgILnqLPlrprmoJHlsLHlj5jmiJDpk77mjqXkuIDkuKrmiJblpJoNCj4g
K+S4queos+WumuagkSLlia/mnKwi55qEIumTviLjgILmr4/kuKrlia/mnKzpg73kv53nlZlLU03p
obXnmoTpgIbmmKDlsITkv6Hmga/vvIzlhbbkuK0gYGBwYWdlLT5tYXBwaW5nYGANCj4gK+aMh+WQ
keivpSLlia/mnKwi44CCDQo+ICsNCj4gK+avj+S4qumTvuS7peWPiumTvuaOpeWIsOivpemTvuS4
reeahOaJgOaciSLlia/mnKwi5by65Yi25LiN5Y+Y55qE5piv77yM5a6D5Lus5Luj6KGo5LqG55u4
5ZCM55qE5YaZ5L+d5oqk5YaF5a2YDQo+ICvlhoXlrrnvvIzlsL3nrqHku7vkuK3kuIDkuKoi5Ymv
5pysIuaYr+eUseWQjOS4gOeJh+WGheWtmOWMuueahOS4jeWQjOeahEtTTeWkjeWItumhteaJgOaM
h+WQkeeahOOAgg0KPiArDQo+ICvov5nmoLfkuIDmnaXvvIznm7jmr5TkuI7ml6DpmZDnmoTpgIbm
mKDlsITpk77ooajvvIznqLPlrprmoJHnmoTmn6Xmib7orqHnrpflpI3mnYLmgKfkuI3lj5flvbHl
k43jgILkvYblnKjnqLPlrprmoJENCj4gK+acrOi6q+S4reS4jeiDveaciemHjeWkjeeahEtTTemh
temdouWGheWuueS7jeeEtuaYr+W8uuWItuimgeaxguOAgg0KPiArDQo+ICvnlLEgYGBtYXhfcGFn
ZV9zaGFyaW5nYGAg5by65Yi25Yaz5a6a55qE5pWw5o2u5Y676YeN6ZmQ5Yi25piv5b+F6KaB55qE
77yM5Lul5q2k5p2l6YG/5YWN6Jma5ouf5YaF5a2YDQo+ICtybWFw6ZO+6KGo5Y+Y5b6X6L+H5aSn
44CCcm1hcOeahOmBjeWOhuWFt+aciU8oTinnmoTlpI3mnYLluqbvvIzlhbbkuK1O5piv5YWx5Lqr
6aG16Z2i55qEcm1hcF/pobnvvIjljbMNCj4gK+iZmuaLn+aYoOWwhO+8ieeahOaVsOmHj++8jOiA
jOi/meS4quWFseS6q+mhtemdoueahOiKgueCueaVsOmHj+WPiOiiqyBgYG1heF9wYWdlX3NoYXJp
bmdgYCDmiYDpmZDliLbjgIINCj4gK+WboOatpO+8jOi/meacieaViOWcsOWwhue6v+aAp08oTino
rqHnrpflpI3mnYLluqbku45ybWFw6YGN5Y6G5Lit5YiG5pWj5Yiw5LiN5ZCM55qES1NN6aG16Z2i
5LiK44CCa3NtZOi/mw0KPiAr56iL5Zyo56iz5a6a6IqC54K5IumTviLkuIrnmoTpgY3ljobkuZ/m
mK9PKE4p77yM5L2G6L+Z5LiqTuaYr+eos+WumuagkSLlia/mnKwi55qE5pWw6YeP77yM6ICM5LiN
5pivcm1hcOmhuQ0KPiAr55qE5pWw6YeP77yM5Zug5q2k5a6D5a+5a3NtZOaAp+iDveayoeacieaY
vuiRl+W9seWTjeOAguWunumZheS4iu+8jOacgOS9s+eos+WumuagkSLlia/mnKwi55qE5YCZ6YCJ
6IqC54K55bCGDQo+ICvkv53nlZnlnKgi5Ymv5pysIuWIl+ihqOeahOW8gOWktOOAgg0KPiArDQo+
ICtgYG1heF9wYWdlX3NoYXJpbmdgYCDnmoTlgLzorr7nva7lvpfpq5jkuobkvJrkv4Pkvb/mm7Tl
v6vnmoTlhoXlrZjlkIjlubbvvIjlm6DkuLrlsIbmnInmm7TlsJHnmoTnqLPlrpoNCj4gK+agkeWJ
r+acrOaOkumYn+i/m+WFpeeos+WumuiKgueCuWNoYWluLT5obGlzdO+8ieWSjOabtOmrmOeahOaV
sOaNruWOu+mHjeezu+aVsO+8jOS9huS7o+S7t+aYr+WcqOS6pOaNouOAgeWOiw0KPiAr57yp44CB
TlVNQeW5s+ihoeWSjOmhtemdoui/geenu+i/h+eoi+S4reWPr+iDveWvvOiHtEtTTemhteeahOac
gOWkp3JtYXDpgY3ljobpgJ/luqbovoPmhaLjgIINCj4gKw0KPiArYGBzdGFibGVfbm9kZV9kdXBz
L3N0YWJsZV9ub2RlX2NoYWluc2BgIOeahOavlOWAvOi/mOWPlyBgYG1heF9wYWdlX3NoYXJpbmdg
YCDosIPmjqcNCj4gK+eahOW9seWTje+8jOmrmOavlOWAvOWPr+iDveaEj+WRs+edgOeos+WumuiK
gueCuWR1cOS4reWtmOWcqOeijueJh++8jOi/meWPr+S7pemAmui/h+WcqGtzbWTkuK3lvJXlhaXn
oo7niYfnrpcNCj4gK+azleadpeino+WGs++8jOivpeeul+azleWwhnJtYXDpobnku47kuIDkuKrn
qLPlrproioLngrlkdXDph43lrprkvY3liLDlj6bkuIDkuKrnqLPlrproioLngrlkdXDvvIzku6Xk
vr/ph4rmlL4NCj4gK+mCo+S6m+S7heWMheWQq+aegeWwkXJtYXDpobnnmoTnqLPlrproioLngrki
ZHVwIu+8jOS9hui/meWPr+iDveS8muWinuWKoGtzbWTov5vnqIvnmoRDUFXkvb/nlKjnjofvvIzl
ubblj68NCj4gK+iDveS8muWHj+aFouW6lOeUqOeoi+W6j+WcqEtTTemhtemdouS4iueahOWPquiv
u+iuoeeul+OAgg0KPiArDQo+ICtLU03kvJrlrprmnJ/miavmj4/nqLPlrproioLngrki6ZO+IuS4
remTvuaOpeeahOaJgOacieeos+WumuagkSLlia/mnKwi77yM5Lul5L6/5Yig5YeP6L+H5pe25LqG
55qE56iz5a6a6IqC54K544CCDQo+ICvov5nnp43miavmj4/nmoTpopHnjofnlLEgYGBzdGFibGVf
bm9kZV9jaGFpbnNfcHJ1bmVfbWlsbGlzZWNzYGAg6L+Z5Liqc3lzZnMg5o6l5Y+j5a6a5LmJ44CC
DQo+ICsNCj4gK+WPguiAgw0KPiArPT09PQ0KPiArLi4ga2VybmVsLWRvYzo6IG1tL2tzbS5jDQo+
ICsgICA6ZnVuY3Rpb25zOiBtbV9zbG90IGtzbV9zY2FuIHN0YWJsZV9ub2RlIHJtYXBfaXRlbQ0K
DQpBbHNvIHJlbW92ZSB0aGVtIHRvby4NCg0KVGhhbmtzDQpBbGV4DQoNCj4gKw0KPiArLS0NCj4g
K+W+kOmRqw0KPiArMjAyMuW5tDHmnIg55pelDQo+DQo=
