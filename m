Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB6512ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiD1Is2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiD1Irs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:47:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461666F97
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:40:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p6so3703026pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OkXGXbOPHTpYIjxBxkyJjocsF1Qn/6hjvv7ynLH3v10=;
        b=T2KPFPWUercpIyW1rqm56mNhIfWEQHg2nNPVfVNk20iXEIb/XdcYLowMGE5LQVGaJY
         oMcRN+ikEOr1i4AkwgvkYUusnXybalqfp29ijKj/iI+b/SLN8VKVXcCe/E5tKS0Yxp3l
         8HQR+/qzsB6z8Io+WsDltIAEGabncojUIzoAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OkXGXbOPHTpYIjxBxkyJjocsF1Qn/6hjvv7ynLH3v10=;
        b=bgADV+wC31RL0t/ES3R3NO0gbqzuDnOqpGU03F3FbETDQodZ7DXqoC+l5aMMyFVE8N
         y0ow/YHlzjwWI7HSXaAHsFWQpd4k3eJJHiWosbjtdMfbBEjSiPhE+epjMx4HE8JGuSZp
         HjjBIiFeIfB8HtdRS/6SXJBx3+muI2az8yQSkbbCY4vMxV+mHwoZQ0DRa/CLfCjr6TRe
         dV1WIPHaNKUicL4nc88PMgD4yk2dGazMDDtsLkCBQqaE2YAAkVvGh3pqp9ePK/W+yAod
         AOC3u22ovBG7EwBKqQ5Bm2ZNU8geJ+2gSy6KWtG1TODnYPigMVojop3NAR4CU9zSj6LV
         XtVw==
X-Gm-Message-State: AOAM531CfDYyn5xf7pqU2t9FR5PLBnK1yTCH3zb5LT8pubr4yHSRdpzB
        rMN02eGOYwv7d6vWUtjN3o1d+zaSN/gHuYhXvEpM8g==
X-Google-Smtp-Source: ABdhPJyLRMFh56wB5twrRw2iMtEQYrRfo73s3gtC847TUA66wBrRVe4W78BUhNsrDVUlCZCPhjNaZ80RKvb/AnG9G/0=
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id
 s23-20020a17090a441700b001caa8613fbfmr48581026pjg.80.1651135238061; Thu, 28
 Apr 2022 01:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220424122745.15386-1-fujimotokosuke0@gmail.com>
In-Reply-To: <20220424122745.15386-1-fujimotokosuke0@gmail.com>
From:   Tsugikazu Shibata <shibata@linuxfoundation.org>
Date:   Thu, 28 Apr 2022 17:40:27 +0900
Message-ID: <CAO+cJp0adp9W22zBbOnUvaLxa2fbsTky431NE_K+MbwyOLpZYQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/ja_JP/howto: Don't mention specific kernel versions
To:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rmlyc3Qgb2YgYWxsLCBUaGFua3MgdG8gRnVqaW1vdG8tc2FuIGFuZCBZb2tvc2F3YS1zYW4gZm9y
IHdha2luZyBtZSB1cC4NCk5vdyBJIGdldCBiYWNrIHRvIGhlcmUgYnkgbmV3IGVtYWlsIGFkZHJl
c3MuDQoNCkkgaGF2ZSBhIGZldyBjb21tZW50cyBhcyBiZWxvdzoNCg0KT24gU3VuLCBBcHIgMjQs
IDIwMjIgYXQgOToyOCBQTSBLb3N1a2UgRnVqaW1vdG8NCjxmdWppbW90b2tvc3VrZTBAZ21haWwu
Y29tPiB3cm90ZToNCj4NCj4gVGhpcyBjaGFuZ2UgaXMgYmFzZWQgb24gY29tbWl0IGQyYjAwOGYx
MzRiNw0KPiAoIkRvY3VtZW50YXRpb24vcHJvY2Vzcy9ob3d0bzogVXBkYXRlIGZvciA0LnggLT4g
NS54IHZlcnNpb25pbmciKS4NCj4NCj4gUmVwbGFjZSAiNC54IGtlcm5lbCB2ZXJzaW9uIiB3aXRo
IGdlbmVyaWMgdGVybSBzdWNoIGFzICJtYWlubGluZSB0cmVlIg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBLb3N1a2UgRnVqaW1vdG8gPGZ1amltb3Rva29zdWtlMEBnbWFpbC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4gQ2M6IEpvbmF0aGFuIENv
cmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+IENjOiBUc3VnaWthenUgU2hpYmF0YSA8c2hpYmF0YUBs
aW51eGZvdW5kYXRpb24ub3JnPg0KPiBDYzogQWtpcmEgWW9rb3Nhd2EgPGFraXlrc0BnbWFpbC5j
b20+DQo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiBWMjogUmVmb3Jt
YXR0ZWQgY29tbWl0IGxvZyBtZXNzYWdlDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvamFfSlAvaG93dG8ucnN0IHwgNDMgKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0IGIvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+IGluZGV4IGQ2NjdmOWQ4
YTAyYS4uOWI3MTE5MzJhZTZkIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMv
amFfSlAvaG93dG8ucnN0DQo+IEBAIC0yNjIsMjEgKzI2MiwyMSBAQCBMaW51eCDjgqvjg7zjg43j
g6vjga7plovnmbrjg5fjg63jgrvjgrnjga/nj77lnKjlub7jgaTjgYvjga7nlbDjgarjgovjg6Hj
gqTjg7MNCj4gIOODgeOAjeOBqOWkmuaVsOOBruOCteODluOCt+OCueODhuODoOavjuOBruOCq+OD
vOODjeODq+ODluODqeODs+ODgeOBi+OCieani+aIkOOBleOCjOOBvuOBmeOAguOBk+OCjOOCieOB
rg0KPiAg44OW44Op44Oz44OB44Go44GvIC0NCj4NCj4gLSAgLSDjg6HjgqTjg7Pjga4gNC54IOOC
q+ODvOODjeODq+ODhOODquODvA0KPiAtICAtIDQueC55IC1zdGFibGUg44Kr44O844ON44Or44OE
44Oq44O8DQo+IC0gIC0g44K144OW44K344K544OG44Og5q+O44Gu44Kr44O844ON44Or44OE44Oq
44O844Go44OR44OD44OBDQo+IC0gIC0g57Wx5ZCI44OG44K544OI44Gu44Gf44KB44GuIDQueCAt
bmV4dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSBMaW51cyDjga7jg6HjgqTjg7Pjg6nj
gqTjg7Pjg4Tjg6rjg7wNCj4gKyAgLSDjg6Hjgrjjg6Pjg7znlarlj7fjgpLjgb7jgZ/jgZDmlbDm
nKzjga7lronlrprniYjjg4Tjg6rjg7wNCj4gKyAgLSDjgrXjg5bjgrfjgrnjg4bjg6Dmr47jga7j
gqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4gKyAgLSDntbHlkIjjg4bjgrnjg4jjga7jgZ/jgoHjga4g
bGludXgtbmV4dCDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4NCj4gLTQueCDjgqvjg7zjg43jg6vj
g4Tjg6rjg7wNCj4gK+ODoeOCpOODs+ODqeOCpOODs+ODhOODquODvA0KPiAgfn5+fn5+fn5+fn5+
fn5+fn5+DQo+DQo+IC00Lngg44Kr44O844ON44Or44GvIExpbnVzIFRvcnZhbGRzIOOBq+OCiOOB
o+OBpuODoeODs+ODhuODiuODs+OCueOBleOCjOOAgQ0KPiAtaHR0cHM6Ly9rZXJuZWwub3JnIOOB
riBwdWIvbGludXgva2VybmVsL3Y0LngvIOODh+OCo+ODrOOCr+ODiOODquOBq+WtmOWcqOOBl+OB
vuOBmeOAgg0KPiAr44Oh44Kk44Oz44Op44Kk44Oz44OE44Oq44O844GvIExpbnVzIFRvcnZhbGRz
IOOBq+OCiOOBo+OBpuODoeODs+ODhuODiuODs+OCueOBleOCjOOAgQ0KPiAraHR0cHM6Ly9rZXJu
ZWwub3JnIOOBruODquODneOCuOODiOODquOBq+WtmOWcqOOBl+OBvuOBmeOAgg0KPiAg44GT44Gu
6ZaL55m644OX44Ot44K744K544Gv5Lul5LiL44Gu44Go44GK44KKIC0NCj4NCj4gICAgLSDmlrDj
gZfjgYTjgqvjg7zjg43jg6vjgYzjg6rjg6rjg7zjgrnjgZXjgozjgZ/nm7TlvozjgavjgIEy6YCx
6ZaT44Gu54m55Yil5pyf6ZaT44GM6Kit44GR44KJ44KM44CBDQo+ICAgICAg44GT44Gu5pyf6ZaT
5Lit44Gr44CB44Oh44Oz44OG44OK6YGU44GvIExpbnVzIOOBq+Wkp+OBjeOBquW3ruWIhuOCkumA
geOCi+OBk+OBqOOBjOOBp+OBjeOBvuOBmeOAgg0KPiAtICAgIOOBk+OBruOCiOOBhuOBquW3ruWI
huOBr+mAmuW4uCAtbmV4dCDjgqvjg7zjg43jg6vjgavmlbDpgLHplpPlkKvjgb7jgozjgabjgY3j
gZ/jg5Hjg4Pjg4HjgafjgZnjgIINCj4gKyAgICDjgZPjga7jgojjgYbjgarlt67liIbjga/pgJrl
uLggbGludXgtbmV4dCDjgqvjg7zjg43jg6vjgavmlbDpgLHplpPlkKvjgb7jgozjgabjgY3jgZ/j
g5Hjg4Pjg4HjgafjgZnjgIINCj4gICAgICDlpKfjgY3jgarlpInmm7Tjga8gZ2l0KOOCq+ODvOOD
jeODq+OBruOCveODvOOCueeuoeeQhuODhOODvOODq+OAgeips+e0sOOBrw0KPiAgICAgIGh0dHA6
Ly9naXQtc2NtLmNvbS8g5Y+C54WnKSDjgpLkvb/jgaPjgabpgIHjgovjga7jgYzlpb3jgb7jgZfj
gYTjgoTjgormlrnjgafjgZnjgYzjgIHjg5Hjg4MNCj4gICAgICDjg4Hjg5XjgqHjgqTjg6vjga7l
vaLlvI/jga7jgb7jgb7pgIHjgovjga7jgafjgoLljYHliIbjgafjgZnjgIINCj4gQEAgLTMwMywy
MCArMzAzLDE3IEBAIEFuZHJldyBNb3J0b24g44GMIExpbnV4LWtlcm5lbCDjg6Hjg7zjg6rjg7Pj
grDjg6rjgrnjg4jjgavjgqvjg7zjg43jg6vjg6rjg6rjg7wNCj4gICAgICAgICAg5YmN44KC44Gj
44Gm5rG644KB44KJ44KM44Gf6KiI55S744Gr44KI44Gj44Gm44Oq44Oq44O844K544GV44KM44KL
44KC44Gu44Gn44Gv44Gq44GE44GL44KJDQo+ICAgICAgICAgIOOBp+OBmeOAguOAjSoNCj4NCj4g
LTQueC55IC1zdGFibGUg44Kr44O844ON44Or44OE44Oq44O8DQo+IC1+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ICvjg6Hjgrjjg6Pjg7znlarlj7fjgpLjgb7jgZ/jgZDmlbDmnKzjga7l
ronlrprniYjjg4Tjg6rjg7wNCj4gK35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPg0KPiAg44OQ44O844K444On44Oz55Wq5Y+344GMM+OBpOOBruaVsOWtl+OBq+WIhuOB
i+OCjOOBpuOBhOOCi+OCq+ODvOODjeODq+OBryAtc3RhYmxlIOOCq+ODvOODjeODq+OBp+OBmeOA
gg0KPiAt44GT44KM44Gr44Gv44CBNC54IOOCq+ODvOODjeODq+OBp+imi+OBpOOBi+OBo+OBn+OC
u+OCreODpeODquODhuOCo+WVj+mhjOOChOmHjeWkp+OBquW+jOaIu+OCiuOBq+WvvuOBmQ0KPiAt
44KL5q+U6LyD55qE5bCP44GV44GE6YeN6KaB44Gq5L+u5q2j44GM5ZCr44G+44KM44G+44GZ44CC
DQo+ICvjgZPjgozjgavjga/mnIDliJ3jga4y44Gk44Gu5pWw5a2X44Gr5a++5b+c44GX44Gf44CB
44Oh44Kk44Oz44Op44Kk44Oz44Oq44Oq44O844K544Gn6KaL44Gk44GL44Gj44Gf44K744Kt44Ol
44Oq44OG44Kj5ZWP6aGM44KEDQoNCkFib3ZlIGxpbmUgY29tZXMgZnJvbToNCi4uLnNlY3VyaXR5
IHByb2JsZW1zIG9yIHNpZ25pZmljYW50IHJlZ3Jlc3Npb25zIGRpc2NvdmVyZWQgaW4gYSBnaXZl
bg0KbWFqb3IgbWFpbmxpbmUgcmVsZWFzZSwNCndpdGggdGhlIGZpcnN0IDItcGFydCBvZiB2ZXJz
aW9uIG51bWJlciBhcmUgdGhlIHNhbWUgY29ycmVzcG9uZGluZ2x5Lg0KDQpJdCBtYXkgYmV0dGVy
IHRvIGJlOg0K44GT44KM44Gr44Gv5pyA5Yid44GuMuOBpOOBruODkOODvOOCuOODp+ODs+eVquWP
t+OBruaVsOWtl+OBq+WvvuW/nOOBl+OBn+OAgeODoeOCpOODs+ODqeOCpOODs+ODquODquODvOOC
ueOBp+imi+OBpOOBi+OBo+OBn+OCu+OCreODpeODquODhuOCo+WVj+mhjOOChA0KDQo+ICvph43l
pKfjgarlvozmiLvjgorjgavlr77jgZnjgovmr5TovIPnmoTlsI/jgZXjgYTph43opoHjgarkv67m
raPjgYzlkKvjgb7jgozjgb7jgZnjgIINCj4NCj4gIOOBk+OCjOOBr+OAgemWi+eZui/lrp/pqJPn
moTjg5Djg7zjgrjjg6fjg7Pjga7jg4bjgrnjg4jjgavljZTlipvjgZnjgovjgZPjgajjgavoiIjl
kbPjgYznhKHjgY/jgIHmnIDmlrANCj4gIOOBruWuieWumuOBl+OBn+OCq+ODvOODjeODq+OCkuS9
v+OBhOOBn+OBhOODpuODvOOCtuOBq+aOqOWlqOOBmeOCi+ODluODqeODs+ODgeOBp+OBmeOAgg0K
Pg0KPiAt44KC44GX44CBNC54Lnkg44Kr44O844ON44Or44GM5a2Y5Zyo44GX44Gq44GE5aC05ZCI
44Gr44Gv44CB55Wq5Y+344GM5LiA55Wq5aSn44GN44GEIDQueCDjgYzmnIDmlrANCj4gLeOBruWu
ieWumueJiOOCq+ODvOODjeODq+OBp+OBmeOAgg0KPiAtDQo+IC00LngueSDjga8gInN0YWJsZSIg
44OB44O844OgIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiDjgafjg6Hjg7Pjg4bjgZXjgozjgabj
gYrjgorjgIENCj4gK+WuieWumueJiOOCq+ODvOODjeODqyDjga8gInN0YWJsZSIg44OB44O844Og
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiDjgafjg6Hjg7Pjg4bjgZXjgozjgabjgYrjgorjgIEN
Cg0KVGhpcyBsaW5lIGNvbWVzIGZyb206DQpTdGFibGUgdHJlZXMgYXJlIG1haW50YWluZWQgYnkg
dGhlICJzdGFibGUiIHRlYW0gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+LCAuLi4NCg0KU28sIEl0
IG1heSBhbHNvIGJldHRlciB0byBiZToNCuWuieWumueJiOODhOODquODvOOBryJzdGFibGUiIOOD
geODvOODoCA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4g44Gn44Oh44Oz44OG44GV44KM44Gm44GK
44KK44CBDQoNCkZvciBvdGhlciBwYXJ0cyBpdCBsb29rcyBnb29kIHRvIG1lLiBJIGhvcGUgeW91
IHdpbGwgZml4IGFuZCBzdWJtaXQNCnlvdXIgcGF0Y2ggYWdhaW4uDQpUaGFuayB5b3UgZm9yIHlv
dXIgcGF0Y2guDQoNClRzdWdpa2F6dSBTaGliYXRhDQo=
