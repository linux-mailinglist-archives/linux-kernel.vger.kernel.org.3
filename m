Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197255158B3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381621AbiD2W4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2W4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:56:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E37839D;
        Fri, 29 Apr 2022 15:53:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p6so8275604pjm.1;
        Fri, 29 Apr 2022 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=igLOqTt7c0+9rOub31h3DCTn/9DZSO8QV11F0F++Etw=;
        b=b+GxKAGp10UA0dEQqzHpFp8qB9TceUV9WwO+8pZhT9cNZjlGDnBj/vXlFfqyxyabqK
         0oxmdIcOMUAovt/fV0li7zUuKcfyh+zOFQaUJwofBjtpSQB4zJMoO3926jM31fk4BeZH
         VEG6+ANfZq96wUR+ukj7qERaxJYDRXOA/9TlM1KoLGW+5ay+Rn4sDQaD/wF5DG8gHwI5
         1GbPJRKLEOrTlFRI2E1YRFNnxT4hX+bQfKf5QbpFm14be9oOsdLT9oKOJR87HWZJhjPj
         /MMJAVeDxFBRXl+nuU8lOMQYSMxzFWgXJc7E3Xkv1bXQGnLl+CWxGHg+bIGzFJkTdA0I
         a9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=igLOqTt7c0+9rOub31h3DCTn/9DZSO8QV11F0F++Etw=;
        b=8N+NGj6ytjsKsYyhbFeYmom8/g7li4BZZHZQ+I21o7JAgyMbImqpA5LsAR8Gow6rAc
         hYx2kJ9E4OsVdse1LZ79K8jtAJS8e+Gb9z1ock9H3uYRfSUUJKsAKc8vTwOX0Nma7bzS
         mgQZmqscqUpAxnc8m24I3LmFjtL/eEwvHxN8Ugnk78zcpJI91t/p/qET5sZt81GdQuTf
         sMv1gDmk1UP8b2wSqRNLKe/4EyVTh+7dvylClVbKYSVhxojIenRHaN44VFdCSakYJowQ
         o3oD5dFMSxUpi0QijkqwrSlTOxKemBySowCPFoF3eHS0Xg9kYjW9qAF2qcR6PlH0sesP
         e4pw==
X-Gm-Message-State: AOAM532k9gDXowCIL/F2rCqzjVBdWjjfXwM+UfAQlnHnpBMBzux91n6G
        yuVDcHR0w/weTKuZVO8k1mZFyKnzZsM=
X-Google-Smtp-Source: ABdhPJxtzHkDldh7HirdrUNvkceKmrTnIWr8Fv5MXfBfPoKrYJ8hbIx/2VQPEaMOroZIxZ1QKgc74g==
X-Received: by 2002:a17:90a:8d82:b0:1d8:a5a9:5489 with SMTP id d2-20020a17090a8d8200b001d8a5a95489mr1389664pjo.102.1651272780803;
        Fri, 29 Apr 2022 15:53:00 -0700 (PDT)
Received: from smtpclient.apple (164.174.128.101.dy.bbexcite.jp. [101.128.174.164])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a6d8800b001cd4c118b07sm11839070pjk.16.2022.04.29.15.52.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 15:53:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3] docs/trans/ja_JP/howto: Don't mention specific kernel
 versions
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
In-Reply-To: <20220429133522.41013-1-fujimotokosuke0@gmail.com>
Date:   Sat, 30 Apr 2022 07:52:56 +0900
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Message-Id: <93D2EBDC-A1F5-4C48-8E59-F6FDDB12735F@gmail.com>
References: <20220429133522.41013-1-fujimotokosuke0@gmail.com>
To:     Tsugikazu Shibata <shibata@linuxfoundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDI5LCAyMDIyLCBhdCAyMjozNSwgS29zdWtlIEZ1amltb3RvIDxmdWppbW90
b2tvc3VrZTBAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IFRoaXMgY2hhbmdlIGlzIGJhc2VkIG9u
IGNvbW1pdCBkMmIwMDhmMTM0YjcNCj4gKCJEb2N1bWVudGF0aW9uL3Byb2Nlc3MvaG93dG86IFVw
ZGF0ZSBmb3IgNC54IC0+IDUueCB2ZXJzaW9uaW5nIikuDQo+IA0KPiBSZXBsYWNlICI0Lngga2Vy
bmVsIHZlcnNpb24iIHdpdGggZ2VuZXJpYyB0ZXJtIHN1Y2ggYXMgIm1haW5saW5lIHRyZWUiDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBLb3N1a2UgRnVqaW1vdG8gPGZ1amltb3Rva29zdWtlMEBnbWFp
bC5jb20+DQo+IC0tLQ0KPiBWMjogUmVmb3JtYXR0ZWQgY29tbWl0IGxvZyBtZXNzYWdlDQo+IFYz
OiBVcGRhdGVkIHNvbWUgZXhwcmVzc2lvbnMNCj4gLSBhZGRlZCAidmVyc2lvbiBudW1iZXIiIGlu
IG1haW5saW5lIHRyZWUgc2VjdGlvbg0KPiAtIHVwZGF0ZWQgZnJvbSAic3RhYmxlIGtlcm5lbCIg
dG8gInN0YWJsZSB0cmVlIg0KPiAtLS0NCj4gLS0tDQo+IERvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL2phX0pQL2hvd3RvLnJzdCB8IDQ0ICsrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gMSBmaWxl
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdCBiL0RvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdA0KPiBpbmRleCBkNjY3ZjlkOGEw
MmEuLmRlYWM0MWViMDM4YSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvamFfSlAvaG93dG8ucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2ph
X0pQL2hvd3RvLnJzdA0KPiBAQCAtMjYyLDIxICsyNjIsMjEgQEAgTGludXgg44Kr44O844ON44Or
44Gu6ZaL55m644OX44Ot44K744K544Gv54++5Zyo5bm+44Gk44GL44Gu55Ww44Gq44KL44Oh44Kk
44OzDQo+IOODgeOAjeOBqOWkmuaVsOOBruOCteODluOCt+OCueODhuODoOavjuOBruOCq+ODvOOD
jeODq+ODluODqeODs+ODgeOBi+OCieani+aIkOOBleOCjOOBvuOBmeOAguOBk+OCjOOCieOBrg0K
PiDjg5bjg6njg7Pjg4Hjgajjga8gLQ0KPiANCj4gLSAgLSDjg6HjgqTjg7Pjga4gNC54IOOCq+OD
vOODjeODq+ODhOODquODvA0KPiAtICAtIDQueC55IC1zdGFibGUg44Kr44O844ON44Or44OE44Oq
44O8DQo+IC0gIC0g44K144OW44K344K544OG44Og5q+O44Gu44Kr44O844ON44Or44OE44Oq44O8
44Go44OR44OD44OBDQo+IC0gIC0g57Wx5ZCI44OG44K544OI44Gu44Gf44KB44GuIDQueCAtbmV4
dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSBMaW51cyDjga7jg6HjgqTjg7Pjg6njgqTj
g7Pjg4Tjg6rjg7wNCj4gKyAgLSDjg6Hjgrjjg6Pjg7znlarlj7fjgpLjgb7jgZ/jgZDmlbDmnKzj
ga7lronlrprniYjjg4Tjg6rjg7wNCj4gKyAgLSDjgrXjg5bjgrfjgrnjg4bjg6Dmr47jga7jgqvj
g7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSDntbHlkIjjg4bjgrnjg4jjga7jgZ/jgoHjga4gbGlu
dXgtbmV4dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gDQo+IC00Lngg44Kr44O844ON44Or44OE
44Oq44O8DQo+ICvjg6HjgqTjg7Pjg6njgqTjg7Pjg4Tjg6rjg7wNCj4gfn5+fn5+fn5+fn5+fn5+
fn5+DQo+IA0KPiAtNC54IOOCq+ODvOODjeODq+OBryBMaW51cyBUb3J2YWxkcyDjgavjgojjgaPj
gabjg6Hjg7Pjg4bjg4rjg7PjgrnjgZXjgozjgIENCj4gLWh0dHBzOi8va2VybmVsLm9yZyDjga4g
cHViL2xpbnV4L2tlcm5lbC92NC54LyDjg4fjgqPjg6zjgq/jg4jjg6rjgavlrZjlnKjjgZfjgb7j
gZnjgIINCj4gK+ODoeOCpOODs+ODqeOCpOODs+ODhOODquODvOOBryBMaW51cyBUb3J2YWxkcyDj
gavjgojjgaPjgabjg6Hjg7Pjg4bjg4rjg7PjgrnjgZXjgozjgIENCj4gK2h0dHBzOi8va2VybmVs
Lm9yZyDjga7jg6rjg53jgrjjg4jjg6rjgavlrZjlnKjjgZfjgb7jgZnjgIINCj4g44GT44Gu6ZaL
55m644OX44Ot44K744K544Gv5Lul5LiL44Gu44Go44GK44KKIC0NCj4gDQo+ICAgLSDmlrDjgZfj
gYTjgqvjg7zjg43jg6vjgYzjg6rjg6rjg7zjgrnjgZXjgozjgZ/nm7TlvozjgavjgIEy6YCx6ZaT
44Gu54m55Yil5pyf6ZaT44GM6Kit44GR44KJ44KM44CBDQo+ICAgICDjgZPjga7mnJ/plpPkuK3j
gavjgIHjg6Hjg7Pjg4bjg4rpgZTjga8gTGludXMg44Gr5aSn44GN44Gq5beu5YiG44KS6YCB44KL
44GT44Go44GM44Gn44GN44G+44GZ44CCDQo+IC0gICAg44GT44Gu44KI44GG44Gq5beu5YiG44Gv
6YCa5bi4IC1uZXh0IOOCq+ODvOODjeODq+OBq+aVsOmAsemWk+WQq+OBvuOCjOOBpuOBjeOBn+OD
keODg+ODgeOBp+OBmeOAgg0KPiArICAgIOOBk+OBruOCiOOBhuOBquW3ruWIhuOBr+mAmuW4uCBs
aW51eC1uZXh0IOOCq+ODvOODjeODq+OBq+aVsOmAsemWk+WQq+OBvuOCjOOBpuOBjeOBn+ODkeOD
g+ODgeOBp+OBmeOAgg0KPiAgICAg5aSn44GN44Gq5aSJ5pu044GvIGdpdCjjgqvjg7zjg43jg6vj
ga7jgr3jg7zjgrnnrqHnkIbjg4Tjg7zjg6vjgIHoqbPntLDjga8NCj4gICAgIGh0dHA6Ly9naXQt
c2NtLmNvbS8g5Y+C54WnKSDjgpLkvb/jgaPjgabpgIHjgovjga7jgYzlpb3jgb7jgZfjgYTjgoTj
gormlrnjgafjgZnjgYzjgIHjg5Hjg4MNCj4gICAgIOODgeODleOCoeOCpOODq+OBruW9ouW8j+OB
ruOBvuOBvumAgeOCi+OBruOBp+OCguWNgeWIhuOBp+OBmeOAgg0KPiBAQCAtMzAzLDIwICszMDMs
MTggQEAgQW5kcmV3IE1vcnRvbiDjgYwgTGludXgta2VybmVsIOODoeODvOODquODs+OCsOODquOC
ueODiOOBq+OCq+ODvOODjeODq+ODquODquODvA0KPiAgICAgICAgIOWJjeOCguOBo+OBpuaxuuOC
geOCieOCjOOBn+ioiOeUu+OBq+OCiOOBo+OBpuODquODquODvOOCueOBleOCjOOCi+OCguOBruOB
p+OBr+OBquOBhOOBi+OCiQ0KPiAgICAgICAgIOOBp+OBmeOAguOAjSoNCj4gDQo+IC00LngueSAt
c3RhYmxlIOOCq+ODvOODjeODq+ODhOODquODvA0KPiAtfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiAr44Oh44K444Oj44O855Wq5Y+344KS44G+44Gf44GQ5pWw5pys44Gu5a6J5a6a54mI
44OE44Oq44O8DQo+ICt+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4g
DQo+IOODkOODvOOCuOODp+ODs+eVquWPt+OBjDPjgaTjga7mlbDlrZfjgavliIbjgYvjgozjgabj
gYTjgovjgqvjg7zjg43jg6vjga8gLXN0YWJsZSDjgqvjg7zjg43jg6vjgafjgZnjgIINCj4gLeOB
k+OCjOOBq+OBr+OAgTQueCDjgqvjg7zjg43jg6vjgafopovjgaTjgYvjgaPjgZ/jgrvjgq3jg6Xj
g6rjg4bjgqPllY/poYzjgoTph43lpKfjgarlvozmiLvjgorjgavlr77jgZkNCj4gLeOCi+avlOi8
g+eahOWwj+OBleOBhOmHjeimgeOBquS/ruato+OBjOWQq+OBvuOCjOOBvuOBmeOAgg0KPiAr44GT
44KM44Gr44Gv5pyA5Yid44GuMuOBpOOBruODkOODvOOCuOODp+ODs+eVquWPt+OBruaVsOWtl+OB
q+WvvuW/nOOBl+OBn+OAgQ0KPiAr44Oh44Kk44Oz44Op44Kk44Oz44Oq44Oq44O844K544Gn6KaL
44Gk44GL44Gj44Gf44K744Kt44Ol44Oq44OG44Kj5ZWP6aGM44KEDQo+ICvph43lpKfjgarlvozm
iLvjgorjgavlr77jgZnjgovmr5TovIPnmoTlsI/jgZXjgYTph43opoHjgarkv67mraPjgYzlkKvj
gb7jgozjgb7jgZnjgIINCj4gDQo+IOOBk+OCjOOBr+OAgemWi+eZui/lrp/pqJPnmoTjg5Djg7zj
grjjg6fjg7Pjga7jg4bjgrnjg4jjgavljZTlipvjgZnjgovjgZPjgajjgavoiIjlkbPjgYznhKHj
gY/jgIHmnIDmlrANCj4g44Gu5a6J5a6a44GX44Gf44Kr44O844ON44Or44KS5L2/44GE44Gf44GE
44Om44O844K244Gr5o6o5aWo44GZ44KL44OW44Op44Oz44OB44Gn44GZ44CCDQo+IA0KPiAt44KC
44GX44CBNC54Lnkg44Kr44O844ON44Or44GM5a2Y5Zyo44GX44Gq44GE5aC05ZCI44Gr44Gv44CB
55Wq5Y+344GM5LiA55Wq5aSn44GN44GEIDQueCDjgYzmnIDmlrANCj4gLeOBruWuieWumueJiOOC
q+ODvOODjeODq+OBp+OBmeOAgg0KPiAtDQo+IC00LngueSDjga8gInN0YWJsZSIg44OB44O844Og
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiDjgafjg6Hjg7Pjg4bjgZXjgozjgabjgYrjgorjgIEN
Cj4gK+WuieWumueJiOODhOODquODvOOBryJzdGFibGUiIOODgeODvOODoCA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4g44Gn44Oh44Oz44OG44GV44KM44Gm44GK44KK44CBDQo+IOW/heimgeOBq+W/
nOOBmOOBpuODquODquODvOOCueOBleOCjOOBvuOBmeOAgumAmuW4uOOBruODquODquODvOOCueac
n+mWk+OBryAy6YCx6ZaT5q+O44Gn44GZ44GM44CB5beuDQo+IOOBl+i/q+OBo+OBn+WVj+mhjOOB
jOOBquOBkeOCjOOBsOOCguOBhuWwkeOBl+mVt+OBj+OBquOCi+OBk+OBqOOCguOBguOCiuOBvuOB
meOAguOCu+OCreODpeODquODhuOCo+mWog0KPiDpgKPjga7llY/poYzjga7loLTlkIjjga/jgZPj
gozjgavlr77jgZfjgabjgaDjgYTjgZ/jgYTjga7loLTlkIjjgIHjgZnjgZDjgavjg6rjg6rjg7zj
grnjgYzjgZXjgozjgb7jgZnjgIINCj4gQEAgLTMyNiw3ICszMjQsNyBAQCBEb2N1bWVudGF0aW9u
L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5yc3Qg44OV44Kh44Kk44Or44Gr44Gv44Gp44Gu
44KI44GG44GqDQo+IOmhnuOBruWkieabtOOBjCAtc3RhYmxlIOODhOODquODvOOBq+WPl+OBkeWF
peOCjOWPr+iDveOBi+OAgeOBvuOBn+ODquODquODvOOCueODl+ODreOCu+OCueOBjOOBqeOBhg0K
PiDli5XjgY/jgYvjgYzoqJjov7DjgZXjgozjgabjgYTjgb7jgZnjgIINCj4gDQo+IC3jgrXjg5bj
grfjgrnjg4bjg6Dmr47jga7jgqvjg7zjg43jg6vjg4Tjg6rjg7zjgajjg5Hjg4Pjg4ENCj4gK+OC
teODluOCt+OCueODhuODoOavjuOBruOCq+ODvOODjeODq+ODhOODquODvA0KPiB+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4g44Gd44KM44Ge44KM44Gu44Kr44O8
44ON44Or44K144OW44K344K544OG44Og44Gu44Oh44Oz44OG44OK6YGU44GvIC0tLSDjgZ3jgZfj
gablpJrjgY/jga7jgqvjg7zjg43jg6sNCj4gQEAgLTM1MSwxOSArMzQ5LDE5IEBAIHF1aWx0IOOC
t+ODquODvOOCuuOBqOOBl+OBpuWFrOmWi+OBleOCjOOBpuOBhOOCi+ODkeODg+ODgeOCreODpeOD
vOOCguS9v+OCj+OCjA0KPiDjgZHjgovjgZPjgajjgYzjgafjgY3jgb7jgZnjgILlpKfpg6jliIbj
ga7jgZPjgozjgonjga4gcGF0Y2h3b3JrIOOBruOCteOCpOODiOOBrw0KPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnLyDjgafjg6rjgrnjg4jjgZXjgozjgabjgYTjgb7jgZnjgIINCj4gDQo+
IC3ntbHlkIjjg4bjgrnjg4jjga7jgZ/jgoHjga4gNC54IC1uZXh0IOOCq+ODvOODjeODq+ODhOOD
quODvA0KPiAtfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAr
57Wx5ZCI44OG44K544OI44Gu44Gf44KB44GuIGxpbnV4LW5leHQg44Kr44O844ON44Or44OE44Oq
44O8DQo+ICt+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
IA0KPiAt44K144OW44K344K544OG44Og44OE44Oq44O844Gu5pu05paw5YaF5a6544GM44Oh44Kk
44Oz44Op44Kk44Oz44GuIDQueCDjg4Tjg6rjg7zjgavjg57jg7zjgrjjgZXjgozjgosNCj4gK+OC
teODluOCt+OCueODhuODoOODhOODquODvOOBruabtOaWsOWGheWuueOBjOODoeOCpOODs+ODqeOC
pOODs+ODhOODquODvOOBq+ODnuODvOOCuOOBleOCjOOCiw0KPiDliY3jgavjgIHjgZ3jgozjgonj
ga/ntbHlkIjjg4bjgrnjg4jjgZXjgozjgovlv4XopoHjgYzjgYLjgorjgb7jgZnjgILjgZPjga7n
m67nmoTjga7jgZ/jgoHjgIHlrp/os6rnmoTjgasNCj4g5YWo44K144OW44K344K544OG44Og44OE
44Oq44O844GL44KJ44G744G85q+O5pel44OX44Or44GV44KM44Gm44Gn44GN44KL54m55Yil44Gq
44OG44K544OI55So44Gu44Oq44Od44K4DQo+IOODiOODquOBjOWtmOWcqOOBl+OBvuOBmS0NCj4g
DQo+ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnLz9wPWxpbnV4L2tlcm5lbC9naXQvbmV4
dC9saW51eC1uZXh0LmdpdA0KPiANCj4gLeOBk+OBruOChOOCiuaWueOBq+OCiOOBo+OBpuOAgS1u
ZXh0IOOCq+ODvOODjeODq+OBr+asoeOBruODnuODvOOCuOapn+S8muOBp+OBqeOCk+OBquOCguOB
ruOBjOODoeOCpOODsw0KPiAt44Op44Kk44Oz44Kr44O844ON44Or44Gr44Oe44O844K444GV44KM
44KL44GL44CB44GK44GK44G+44GL44Gq44Gu5bGV5pyb44KS5o+Q5L6b44GX44G+44GZ44CCLW5l
eHQg44Kr44O8DQo+IC3jg43jg6vjga7lrp/ooYzjg4bjgrnjg4jjgpLooYzjgYblhpLpmbrlpb3j
gY3jgarjg4bjgrnjgr/jg7zjga/lpKfjgYTjgavmrZPov47jgZXjgozjgb7jgZnjgIINCj4gK+OB
k+OBruOChOOCiuaWueOBq+OCiOOBo+OBpuOAgWxpbnV4LW5leHQg44Gv5qyh44Gu44Oe44O844K4
5qmf5Lya44Gn44Gp44KT44Gq44KC44Gu44GM44Oh44Kk44OzDQo+ICvjg6njgqTjg7Pjgavjg57j
g7zjgrjjgZXjgozjgovjgYvjgIHjgYrjgYrjgb7jgYvjgarjga7lsZXmnJvjgpLmj5DkvpvjgZfj
gb7jgZnjgIINCj4gK2xpbnV4LW5leHQg44Gu5a6f6KGM44OG44K544OI44KS6KGM44GG5YaS6Zm6
5aW944GN44Gq44OG44K544K/44O844Gv5aSn44GE44Gr5q2T6L+O44GV44KM44G+44GZ44CCDQo+
IA0KPiDjg5DjgrDjg6zjg53jg7zjg4gNCj4gLS0tLS0tLS0tLS0tLQ0KPiAtLSANCj4gMi4yNS4x
DQo+IA0KDQoNCk15IGFwb2xvZ2llcy4NCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHZlcnNpb24gc2lu
Y2UgSSBmb3Jnb3QgdG8gYWRkIHJldmlld2VkIGJ5IHRhZy4NCg0KQmVzdCByZWdhcmRzLA0KS29z
dWtlDQoNCg0K
