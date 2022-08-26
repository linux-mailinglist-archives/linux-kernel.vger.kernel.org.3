Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E865A2FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiHZTbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:31:10 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA2DF081;
        Fri, 26 Aug 2022 12:31:07 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 27QJUcRD001061;
        Sat, 27 Aug 2022 04:30:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 27QJUcRD001061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661542239;
        bh=+nw3Nx+rFUerwVQE7ZwmA3S056SF1lsKenKwHJV0wp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NQ3pqEANnoMsyzTO09OVpDVr687r0Op9rQBlLNfhE3L9+rIhJlG2i7oSrWgVwiRLX
         LRc+ZgGo87rm6o6XGZZ+srJfkLpt+ciw2FP4Dsja3y0OY7uvRpNzqM6beONdqBQNYY
         PomEEJTSRFlBduZirSc26kaa50Kk0xk/3/xrUaR/YCP5l9LKpy4kJUlihqvLRuQljH
         5piDYIa4TpW6nr+oIlSi5uOnWMLlnfTkuJOARzdfXMgK+QTUa/ewTCOhgJ5QtuX9zV
         kIo7J1G83hJPMHdSQwxviYRVsGQgiugU2eHtoPQO/NU6fkbV1HoI8tkogUEM9JYQP/
         J/buXldLdWSKg==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11c896b879bso3301490fac.3;
        Fri, 26 Aug 2022 12:30:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo397Y28jqUsbYOUpCA2cdabYen8HVrv+aDEFr6NGRgb84JAVP9p
        nKBoF4ArzfPx4Xc2PKyJVWBUOUmdPMiv7Q6I33I=
X-Google-Smtp-Source: AA6agR44EvWwy8CvbYlUTJWEeYNapNxihNzWItB2ttXfjVDxBLVDsCYk7Og6OUpuQ9Ohmx6x+Fi9G1nUTWOektEokh8=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr2517902oab.194.1661542237976; Fri, 26
 Aug 2022 12:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220824203934.2855320-1-robh@kernel.org>
In-Reply-To: <20220824203934.2855320-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Aug 2022 04:30:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8nH+9HnfhV8yEtxShBbSYGQdOyVxbNJmbQJjEiqHPzA@mail.gmail.com>
Message-ID: <CAK7LNAS8nH+9HnfhV8yEtxShBbSYGQdOyVxbNJmbQJjEiqHPzA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Split up DT binding build targets
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e000e005e729f253"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e000e005e729f253
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 25, 2022 at 5:39 AM Rob Herring <robh@kernel.org> wrote:
>
> The DT binding validation target, dt_binding_check, is composed of
> multiple steps which can't be run individually. This resulted in
> the passing of make variables to control which steps were run for
> 'dtbs_check'. Some steps are also doing multiple things in a single rule
> which is error prone[1].
>
> Rework the build to split each of the steps into its own make target.
> This allows users more fine grained control over what's run and makes
> for easier make dependencies.


I do not think it makes the code easier.


A tricky case is that multiple targets run in parallel.


"make  -j$(nproc)  dtbs_check  dt_binding_examples"


Two different threads dive into Documentation/devicetree/bindings/Makefile,
and try to build the same file simultaneously.

If you run the command above, you will see two lines of

  SCHEMA  Documentation/devicetree/bindings/processed-schema.json

processed-schema.json may result in a corrupted file.





> The new targets are:
>
> dt_binding_lint - Runs yamllint on the bindings
> dt_binding_schemas - Validates the binding schemas
> dt_binding_examples - Builds and validates the binding examples


I still do not understand why so many phony targets are necessary.

Why isn't the change as simple as the attached file?


-- 
Best Regards
Masahiro Yamada

--000000000000e000e005e729f253
Content-Type: text/x-patch; charset="US-ASCII"; name="diff.patch"
Content-Disposition: attachment; filename="diff.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l7av8q5t0>
X-Attachment-Id: f_l7av8q5t0

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZSBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZQppbmRleCAxZWFjY2Yx
MzViMzAuLjQyOGViMDFkMmZjMiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL01ha2VmaWxlCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9NYWtlZmlsZQpAQCAtMyw5ICszLDYgQEAgRFRfRE9DX0NIRUNLRVIgPz0gZHQtZG9jLXZhbGlk
YXRlCiBEVF9FWFRSQUNUX0VYID89IGR0LWV4dHJhY3QtZXhhbXBsZQogRFRfTUtfU0NIRU1BID89
IGR0LW1rLXNjaGVtYQogCi1EVF9TQ0hFTUFfTElOVCA9ICQoc2hlbGwgd2hpY2ggeWFtbGxpbnQg
fHwgXAotICBlY2hvICJ3YXJuaW5nOiBweXRob24gcGFja2FnZSAneWFtbGxpbnQnIG5vdCBpbnN0
YWxsZWQsIHNraXBwaW5nIiA+JjIpCi0KIERUX1NDSEVNQV9NSU5fVkVSU0lPTiA9IDIwMjIuMwog
CiBQSE9OWSArPSBjaGVja19kdHNjaGVtYV92ZXJzaW9uCkBAIC0zMiwxMyArMjksMjUgQEAgZmlu
ZF9jbWQgPSAkKGZpbmRfYWxsX2NtZCkgfCBncmVwIC1GICIkKERUX1NDSEVNQV9GSUxFUykiCiBD
SEtfRFRfRE9DUyA6PSAkKHNoZWxsICQoZmluZF9jbWQpKQogCiBxdWlldF9jbWRfeWFtbGxpbnQg
PSBMSU5UICAgICQoc3JjKQotICAgICAgY21kX3lhbWxsaW50ID0gKCQoZmluZF9jbWQpIHwgXAor
ICAgICAgY21kX3lhbWxsaW50ID0gaWYgISBjb21tYW5kIC12IHlhbWxsaW50ID4vZGV2L251bGw7
IHRoZW4gXAorICAgICAgICAgICAgICAgICAgICAgICAgIGVjaG8gIndhcm5pbmc6IHB5dGhvbiBw
YWNrYWdlICd5YW1sbGludCcgbm90IGluc3RhbGxlZCwgc2tpcHBpbmciID4mMjsgXAorICAgICAg
ICAgICAgICAgICAgICAgICAgIGV4aXQgMDsgXAorICAgICAgICAgICAgICAgICAgICAgZmk7IFwK
KyAgICAgICAgICAgICAgICAgICAgICgkKGZpbmRfY21kKSB8IFwKICAgICAgICAgICAgICAgICAg
ICAgIHhhcmdzIC1uMjAwIC1QJCQobnByb2MpIFwKLQkJICAgICAkKERUX1NDSEVNQV9MSU5UKSAt
ZiBwYXJzYWJsZSAtYyAkKHNyY3RyZWUpLyQoc3JjKS8ueWFtbGxpbnQgPiYyKSB8fCB0cnVlCisg
ICAgICAgICAgICAgICAgICAgICB5YW1sbGludCAtZiBwYXJzYWJsZSAtYyAkKHNyY3RyZWUpLyQo
c3JjKS8ueWFtbGxpbnQgPiYyKSB8fCB0cnVlOyBcCisgICAgICAgICAgICAgICAgICAgICB0b3Vj
aCAkQAorCiskKG9iaikvZHRfYmluZGluZ19saW50LmNoZWNrZWQ6ICQoQ0hLX0RUX0RPQ1MpICQo
c3JjKS8ueWFtbGxpbnQgRk9SQ0UKKwkkKGNhbGwgaWZfY2hhbmdlZCx5YW1sbGludCkKIAotcXVp
ZXRfY21kX2Noa19iaW5kaW5ncyA9IENIS0RUICAgJEAKK3F1aWV0X2NtZF9jaGtfYmluZGluZ3Mg
PSBDSEtEVCAgICQoc3JjKQogICAgICAgY21kX2Noa19iaW5kaW5ncyA9ICgkKGZpbmRfY21kKSB8
IFwKLSAgICAgICAgICAgICAgICAgICAgICAgICB4YXJncyAtbjIwMCAtUCQkKG5wcm9jKSAkKERU
X0RPQ19DSEVDS0VSKSAtdSAkKHNyY3RyZWUpLyQoc3JjKSkgfHwgdHJ1ZQorICAgICAgICAgICAg
ICAgICAgICAgICAgIHhhcmdzIC1uMjAwIC1QJCQobnByb2MpICQoRFRfRE9DX0NIRUNLRVIpIC11
ICQoc3JjdHJlZSkvJChzcmMpKSB8fCB0cnVlOyBcCisgICAgICAgICAgICAgICAgICAgICAgICAg
dG91Y2ggJEAKKworJChvYmopL2R0X2JpbmRpbmdfc2NoZW1hcy5jaGVja2VkOiAkKENIS19EVF9E
T0NTKSBjaGVja19kdHNjaGVtYV92ZXJzaW9uIEZPUkNFCisJJChjYWxsIGlmX2NoYW5nZWQsY2hr
X2JpbmRpbmdzKQogCiBxdWlldF9jbWRfbWtfc2NoZW1hID0gU0NIRU1BICAkQAogICAgICAgY21k
X21rX3NjaGVtYSA9IGY9JCQobWt0ZW1wKSA7IFwKQEAgLTQ2LDE0ICs1NSwxMSBAQCBxdWlldF9j
bWRfbWtfc2NoZW1hID0gU0NIRU1BICAkQAogICAgICAgICAgICAgICAgICAgICAgICQoRFRfTUtf
U0NIRU1BKSAtaiAkKERUX01LX1NDSEVNQV9GTEFHUykgQCQkZiA+ICRAIDsgXAogCQkgICAgICBy
bSAtZiAkJGYKIAotZGVmaW5lIHJ1bGVfY2hrZHQKLQkkKGlmICQoRFRfU0NIRU1BX0xJTlQpLCQo
Y2FsbCBjbWQseWFtbGxpbnQpLCkKLQkkKGNhbGwgY21kLGNoa19iaW5kaW5ncykKLQkkKGNhbGwg
Y21kLG1rX3NjaGVtYSkKLWVuZGVmCi0KIERUX0RPQ1MgPSAkKHBhdHN1YnN0ICQoc3JjdHJlZSkv
JSwlLCQoc2hlbGwgJChmaW5kX2FsbF9jbWQpKSkKIAorJChvYmopL3Byb2Nlc3NlZC1zY2hlbWEu
anNvbjogJChEVF9ET0NTKSBjaGVja19kdHNjaGVtYV92ZXJzaW9uIEZPUkNFCisJJChjYWxsIGlm
X2NoYW5nZWQsbWtfc2NoZW1hKQorCiBvdmVycmlkZSBEVENfRkxBR1MgOj0gXAogCS1Xbm8tYXZv
aWRfdW5uZWNlc3NhcnlfYWRkcl9zaXplIFwKIAktV25vLWdyYXBoX2NoaWxkX2FkZHJlc3MgXApA
QCAtNjQsMTAgKzcwLDggQEAgb3ZlcnJpZGUgRFRDX0ZMQUdTIDo9IFwKICMgRGlzYWJsZSB1bmRv
Y3VtZW50ZWQgY29tcGF0aWJsZSBjaGVja3MgdW50aWwgd2FybmluZyBmcmVlCiBvdmVycmlkZSBE
VF9DSEVDS0VSX0ZMQUdTID89CiAKLSQob2JqKS9wcm9jZXNzZWQtc2NoZW1hLmpzb246ICQoRFRf
RE9DUykgJChzcmMpLy55YW1sbGludCBjaGVja19kdHNjaGVtYV92ZXJzaW9uIEZPUkNFCi0JJChj
YWxsIGlmX2NoYW5nZWRfcnVsZSxjaGtkdCkKLQogYWx3YXlzLXkgKz0gcHJvY2Vzc2VkLXNjaGVt
YS5qc29uCithbHdheXMtJChDSEVDS19EVF9CSU5ESU5HKSArPSBkdF9iaW5kaW5nX2xpbnQuY2hl
Y2tlZCBkdF9iaW5kaW5nX3NjaGVtYXMuY2hlY2tlZAogYWx3YXlzLSQoQ0hFQ0tfRFRfQklORElO
RykgKz0gJChwYXRzdWJzdCAkKHNyY3RyZWUpLyQoc3JjKS8lLnlhbWwsJS5leGFtcGxlLmR0cywg
JChDSEtfRFRfRE9DUykpCiBhbHdheXMtJChDSEVDS19EVF9CSU5ESU5HKSArPSAkKHBhdHN1YnN0
ICQoc3JjdHJlZSkvJChzcmMpLyUueWFtbCwlLmV4YW1wbGUuZHRiLCAkKENIS19EVF9ET0NTKSkK
IAo=
--000000000000e000e005e729f253--
