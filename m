Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9835132CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbiD1Lux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiD1Luv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:50:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF968983;
        Thu, 28 Apr 2022 04:47:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o69so2712427pjo.3;
        Thu, 28 Apr 2022 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N6IBRFyqHzyovjymn28OuFX1kLvXKvlfEABFpAl56Ps=;
        b=VrP78e9NkPWgsFtyhw6+WX9d2tl4k+ckSvK5CUUUJJGoeEtm74AsIk849tLFxF0CC2
         bj425Kjif46MeiiUyhkqigysawm3UqxemI6zA2UDPC9+LwjKca46Sz86KtR/nNNU+Egj
         Gyb8ckVVkYoMuL5A/fuacx/asgWgUiJuwGUyLZ4tuRev+r1nDvIeDhLg0ihio55ShX5F
         tUCrp3L2k2+NocbZaEFeT3/rkkT/o/MMvuSA7/lbTPSCS+iyMrvBFRpfJHqRVRTL0BAH
         JOD+KUXWIvMBKI8IYvpMwk5tazgZWUs9HF9w35Rd8uCFiOVXXNSw2pe6fdqmAhKUA9mW
         9CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N6IBRFyqHzyovjymn28OuFX1kLvXKvlfEABFpAl56Ps=;
        b=cJ/r7rOFuNQRKEjpVL7HgIjfp8cb/NdTCpNcXxOR9ykleWyUpO3PnuczoTatj2GWp3
         FiWgeYCWRnBScil+AtjF/howBQWSyO7wEXl5VG6owuSoyF8qKN00RKY6NNjw9DL994II
         uu+sCcIq/5mYY/y5qUjEIiFDVidvXCY/Fub4d6UzpxfiEQyI5cguKWBwQ6MWmnF7Lyov
         yr9nGhpUdnrJBqQk14UHvk467q0AbrouCWztNJ9w6aguAsAUdLawyXeTCzZ01NssXp2n
         aBo9yb9b9zCYuuYmyMmzaFiHg5/2NmyH/5yf2i93ZDL7o5p0/Wsh3B63xNItxd9KMMJ3
         IgeA==
X-Gm-Message-State: AOAM53301iV56+Vmm1c/UfuymoIbdrc5Is/10aDp7s/r4ww1NBQG5Mka
        YWmnbvikBIomQLn4AvsKw1YtqYQsNFw=
X-Google-Smtp-Source: ABdhPJygekZSmJALXd+BjpZZ3XSqug8GWwU+/IAOngNvyJ/8cGw9aReDJenijONtLuqbTOW2DbKG4g==
X-Received: by 2002:a17:903:2309:b0:15c:e766:994e with SMTP id d9-20020a170903230900b0015ce766994emr26601005plh.29.1651146456459;
        Thu, 28 Apr 2022 04:47:36 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 1-20020a631541000000b003c14af50646sm2608695pgv.94.2022.04.28.04.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 04:47:35 -0700 (PDT)
Message-ID: <a332cd81-c234-7bff-ac2b-f19a4368210a@gmail.com>
Date:   Thu, 28 Apr 2022 20:47:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] docs/ja_JP/howto: Don't mention specific kernel
 versions
Content-Language: en-US
To:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220424122745.15386-1-fujimotokosuke0@gmail.com>
 <CAO+cJp0adp9W22zBbOnUvaLxa2fbsTky431NE_K+MbwyOLpZYQ@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <CAO+cJp0adp9W22zBbOnUvaLxa2fbsTky431NE_K+MbwyOLpZYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyOCBBcHIgMjAyMiAxNzo0MDoyNyArMDkwMCwNClRzdWdpa2F6dSBTaGliYXRh
IHdyb3RlOg0KPiBGaXJzdCBvZiBhbGwsIFRoYW5rcyB0byBGdWppbW90by1zYW4gYW5kIFlv
a29zYXdhLXNhbiBmb3Igd2FraW5nIG1lIHVwLg0KPiBOb3cgSSBnZXQgYmFjayB0byBoZXJl
IGJ5IG5ldyBlbWFpbCBhZGRyZXNzLg0KDQpXZWxjb21lIGJhY2ssIFNoaWJhdGEtc2FuIQ0K
DQo+IA0KPiBJIGhhdmUgYSBmZXcgY29tbWVudHMgYXMgYmVsb3c6DQo+IA0KPiBPbiBTdW4s
IEFwciAyNCwgMjAyMiBhdCA5OjI4IFBNIEtvc3VrZSBGdWppbW90bw0KPiA8ZnVqaW1vdG9r
b3N1a2UwQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhpcyBjaGFuZ2UgaXMgYmFzZWQg
b24gY29tbWl0IGQyYjAwOGYxMzRiNw0KPj4gKCJEb2N1bWVudGF0aW9uL3Byb2Nlc3MvaG93
dG86IFVwZGF0ZSBmb3IgNC54IC0+IDUueCB2ZXJzaW9uaW5nIikuDQo+Pg0KPj4gUmVwbGFj
ZSAiNC54IGtlcm5lbCB2ZXJzaW9uIiB3aXRoIGdlbmVyaWMgdGVybSBzdWNoIGFzICJtYWlu
bGluZSB0cmVlIg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtvc3VrZSBGdWppbW90byA8ZnVq
aW1vdG9rb3N1a2UwQGdtYWlsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBa2lyYSBZb2tvc2F3
YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBs
d24ubmV0Pg0KPj4gQ2M6IFRzdWdpa2F6dSBTaGliYXRhIDxzaGliYXRhQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQo+PiBDYzogQWtpcmEgWW9rb3Nhd2EgPGFraXlrc0BnbWFpbC5jb20+DQo+
PiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPj4gLS0tDQo+PiBWMjogUmVmb3Jt
YXR0ZWQgY29tbWl0IGxvZyBtZXNzYWdlDQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL3Ry
YW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QgfCA0MyArKysrKysrKysrLS0tLS0tLS0tLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9K
UC9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5y
c3QNCj4+IGluZGV4IGQ2NjdmOWQ4YTAyYS4uOWI3MTE5MzJhZTZkIDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvamFfSlAvaG93dG8ucnN0DQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNClsuLi5dDQo+
PiAtNC54LnkgLXN0YWJsZSDjgqvjg7zjg43jg6vjg4Tjg6rjg7wNCj4+IC1+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiAr44Oh44K444Oj44O855Wq5Y+344KS44G+44Gf44GQ
5pWw5pys44Gu5a6J5a6a54mI44OE44Oq44O8DQo+PiArfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+Pg0KPj4gIOODkOODvOOCuOODp+ODs+eVquWPt+OBjDPj
gaTjga7mlbDlrZfjgavliIbjgYvjgozjgabjgYTjgovjgqvjg7zjg43jg6vjga8gLXN0YWJs
ZSDjgqvjg7zjg43jg6vjgafjgZnjgIINCj4+IC3jgZPjgozjgavjga/jgIE0Lngg44Kr44O8
44ON44Or44Gn6KaL44Gk44GL44Gj44Gf44K744Kt44Ol44Oq44OG44Kj5ZWP6aGM44KE6YeN
5aSn44Gq5b6M5oi744KK44Gr5a++44GZDQo+PiAt44KL5q+U6LyD55qE5bCP44GV44GE6YeN
6KaB44Gq5L+u5q2j44GM5ZCr44G+44KM44G+44GZ44CCDQo+PiAr44GT44KM44Gr44Gv5pyA
5Yid44GuMuOBpOOBruaVsOWtl+OBq+WvvuW/nOOBl+OBn+OAgeODoeOCpOODs+ODqeOCpOOD
s+ODquODquODvOOCueOBp+imi+OBpOOBi+OBo+OBn+OCu+OCreODpeODquODhuOCo+WVj+mh
jOOChA0KPiANCj4gQWJvdmUgbGluZSBjb21lcyBmcm9tOg0KPiAuLi5zZWN1cml0eSBwcm9i
bGVtcyBvciBzaWduaWZpY2FudCByZWdyZXNzaW9ucyBkaXNjb3ZlcmVkIGluIGEgZ2l2ZW4N
Cj4gbWFqb3IgbWFpbmxpbmUgcmVsZWFzZSwNCj4gd2l0aCB0aGUgZmlyc3QgMi1wYXJ0IG9m
IHZlcnNpb24gbnVtYmVyIGFyZSB0aGUgc2FtZSBjb3JyZXNwb25kaW5nbHkuDQo+IA0KPiBJ
dCBtYXkgYmV0dGVyIHRvIGJlOg0KPiDjgZPjgozjgavjga/mnIDliJ3jga4y44Gk44Gu44OQ
44O844K444On44Oz55Wq5Y+344Gu5pWw5a2X44Gr5a++5b+c44GX44Gf44CB44Oh44Kk44Oz
44Op44Kk44Oz44Oq44Oq44O844K544Gn6KaL44Gk44GL44Gj44Gf44K744Kt44Ol44Oq44OG
44Kj5ZWP6aGM44KEDQoNClRoaXMgbG9va3MgbW9yZSBmYWl0aGZ1bC4NCg0KPiANCj4+ICvp
h43lpKfjgarlvozmiLvjgorjgavlr77jgZnjgovmr5TovIPnmoTlsI/jgZXjgYTph43opoHj
garkv67mraPjgYzlkKvjgb7jgozjgb7jgZnjgIINCj4+DQo+PiAg44GT44KM44Gv44CB6ZaL
55m6L+Wun+mok+eahOODkOODvOOCuOODp+ODs+OBruODhuOCueODiOOBq+WNlOWKm+OBmeOC
i+OBk+OBqOOBq+iIiOWRs+OBjOeEoeOBj+OAgeacgOaWsA0KPj4gIOOBruWuieWumuOBl+OB
n+OCq+ODvOODjeODq+OCkuS9v+OBhOOBn+OBhOODpuODvOOCtuOBq+aOqOWlqOOBmeOCi+OD
luODqeODs+ODgeOBp+OBmeOAgg0KPj4NCj4+IC3jgoLjgZfjgIE0LngueSDjgqvjg7zjg43j
g6vjgYzlrZjlnKjjgZfjgarjgYTloLTlkIjjgavjga/jgIHnlarlj7fjgYzkuIDnlarlpKfj
gY3jgYQgNC54IOOBjOacgOaWsA0KPj4gLeOBruWuieWumueJiOOCq+ODvOODjeODq+OBp+OB
meOAgg0KPj4gLQ0KPj4gLTQueC55IOOBryAic3RhYmxlIiDjg4Hjg7zjg6AgPHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmc+IOOBp+ODoeODs+ODhuOBleOCjOOBpuOBiuOCiuOAgQ0KPj4gK+Wu
ieWumueJiOOCq+ODvOODjeODqyDjga8gInN0YWJsZSIg44OB44O844OgIDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPiDjgafjg6Hjg7Pjg4bjgZXjgozjgabjgYrjgorjgIENCj4gDQo+IFRo
aXMgbGluZSBjb21lcyBmcm9tOg0KPiBTdGFibGUgdHJlZXMgYXJlIG1haW50YWluZWQgYnkg
dGhlICJzdGFibGUiIHRlYW0gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+LCAuLi4NCj4gDQo+
IFNvLCBJdCBtYXkgYWxzbyBiZXR0ZXIgdG8gYmU6DQo+IOWuieWumueJiOODhOODquODvOOB
ryJzdGFibGUiIOODgeODvOODoCA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4g44Gn44Oh44Oz
44OG44GV44KM44Gm44GK44KK44CBDQoNCkRpdHRvLg0KDQpGdWppbW90by1zYW4sIHBsZWFz
ZSBrZWVwIG15IFJldmlld2VkLWJ5OiB0YWcgaW4gdGhlIG5leHQgc3Bpbi4NCg0KICAgICAg
ICBUaGFua3MsIEFraXJhDQoNCj4gDQo+IEZvciBvdGhlciBwYXJ0cyBpdCBsb29rcyBnb29k
IHRvIG1lLiBJIGhvcGUgeW91IHdpbGwgZml4IGFuZCBzdWJtaXQNCj4geW91ciBwYXRjaCBh
Z2Fpbi4NCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gVHN1Z2lrYXp1IFNo
aWJhdGENCg==
