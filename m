Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B9357CEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiGUP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGUP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:28:19 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24A7E834;
        Thu, 21 Jul 2022 08:28:18 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id o10so879923vkl.3;
        Thu, 21 Jul 2022 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2ABOAhbNUvDmFBr5+kPISE8py0yDxYD2k6gjXgSabzw=;
        b=dBP3D2j7Zbfyd9lBMrfA3+rBVYUf1xyi3KeCVbhGycv18vrz+uD2EUIG/ljS0fQ5ii
         gQGN18QnCtOtTaoNVF24jzmPKWWy41TxcwDAA2KtIRtKSufoN7g+HcUk1VAUF4iQqS/l
         QOfxLMMChEtlQaS37rk0/fRxItkRu/6XKXWWgqEyDuns5jC72HuKUCBp6Wc+6tWhs1fy
         oea4UuyrjTpJAGftjfEgY+nhUHLAR2ZJyC9mrNRm4sC0YSyxucCfkCs8SH7+n0CPUBer
         b6Gm1PSZJB9mqbBgPITOkYAsCavkWlwU62tvQUb+x5um7PczfjyFyG9zgjg4xojJIbFp
         x1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2ABOAhbNUvDmFBr5+kPISE8py0yDxYD2k6gjXgSabzw=;
        b=TP7WSfPjcB/mQddHl8by3Cbgm83pAwgyHHTah4KqXEh8wvQwKMumjs3s/yAY3nCwyS
         xtRse0wAsmwDp2F9Q7eGMPIOWxgsk5f7qog9CifCv1nYiWnWoYPYriYxcO4kjkGaaTeF
         22W5RhqRlbghOprwaqFZ+ZSN9uqqyuYkEEojpFrix6nIRmSJdcMvgR61x6XeM5R+SPx5
         RBqHGov9yQbgK3zgyNU5zvuK+r/O1qFRp198lC1u57qEhGdRraho5338x2XnrgisyzT1
         w/lexvR82aMfmD04+8fxxFlOattXabCacJZFknx8p/IKJT0uWP9kU4QaafD0KBV2SAlo
         W+QQ==
X-Gm-Message-State: AJIora9fvqJhtq0jQ0jaHI+jRm+/mLMrdz2Z/vc5leCJKThg9IcTCFnQ
        Gj+om3pd2f4KzFkBIgR9p+ODxBXAjDmHgkv2AcfDn1MurIPA4A==
X-Google-Smtp-Source: AGRyM1vNMcqyiN2b4w6Eng0CYE9EaMj0cXEOhZIVlptz/ytKraa77603uWNjtnllPoz3OreWA3lwHzbbHZ0gcAFn0mo=
X-Received: by 2002:a05:6122:11a9:b0:374:8a3d:ba60 with SMTP id
 y9-20020a05612211a900b003748a3dba60mr15397442vkn.24.1658417297616; Thu, 21
 Jul 2022 08:28:17 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 21 Jul 2022 10:28:06 -0500
Message-ID: <CAH2r5msxJU+nTN14LSd6tmFtpgRY4o+-SVktHoqoeD03XepUPw@mail.gmail.com>
Subject: [PATCH][CIFS] update MAINTAINERS files with reviewers for cifs.ko
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ea5d4205e4525dba"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ea5d4205e4525dba
Content-Type: text/plain; charset="UTF-8"

And also correct the URL for the project web site. See attached.



-- 
Thanks,

Steve

--000000000000ea5d4205e4525dba
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-update-MAINTAINERS-file-with-reviewers.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-update-MAINTAINERS-file-with-reviewers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5v6tt6s0>
X-Attachment-Id: f_l5v6tt6s0

RnJvbSA1NzY1NjQ4NzQ2M2IzN2E5MzE0ZjM5ZDczY2QwZmNlNjM3MTM3NzIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMjEgSnVsIDIwMjIgMTA6MjI6NDggLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiB1cGRhdGUgTUFJTlRBSU5FUlMgZmlsZSB3aXRoIHJldmlld2VycwoKQW5kIGFsc28gY29y
cmVjdCB0aGUgVVJMIGZvciB0aGUgcHJvamVjdCB3ZWIgc2l0ZS4KClNpZ25lZC1vZmYtYnk6IFN0
ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBNQUlOVEFJTkVSUyB8IDcg
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDY1MTYxNmVkOGFl
Mi4uODVmMWRkODUxODEyIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVS
UwpAQCAtNTA1NSwxMiArNTA1NSwxNSBAQCBGOglpbmNsdWRlL2xpbnV4L2Nsay8KIEY6CWluY2x1
ZGUvbGludXgvb2ZfY2xrLmgKIFg6CWRyaXZlcnMvY2xrL2Nsa2Rldi5jCiAKLUNPTU1PTiBJTlRF
Uk5FVCBGSUxFIFNZU1RFTSBDTElFTlQgKENJRlMpCitDT01NT04gSU5URVJORVQgRklMRSBTWVNU
RU0gQ0xJRU5UIChDSUZTIGFuZCBTTUIzKQogTToJU3RldmUgRnJlbmNoIDxzZnJlbmNoQHNhbWJh
Lm9yZz4KK1I6CVBhdWxvIEFsY2FudGFyYSA8cGNAY2pyLm56PiAoREZTLCBnbG9iYWwgbmFtZSBz
cGFjZSkKK1I6CVJvbm5pZSBTYWhsYmVyZyA8bHNhaGxiZXJAcmVkaGF0LmNvbT4gKGRpcmVjdG9y
eSBsZWFzZXMsIHNwYXJzZSBmaWxlcykKK1I6CVNoeWFtIFByYXNhZCBOIDxzcHJhc2FkQG1pY3Jv
c29mdC5jb20+IChtdWx0aWNoYW5uZWwpCiBMOglsaW51eC1jaWZzQHZnZXIua2VybmVsLm9yZwog
TDoJc2FtYmEtdGVjaG5pY2FsQGxpc3RzLnNhbWJhLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vi
c2NyaWJlcnMpCiBTOglTdXBwb3J0ZWQKLVc6CWh0dHA6Ly9saW51eC1jaWZzLnNhbWJhLm9yZy8K
K1c6CWh0dHBzOi8vd2lraS5zYW1iYS5vcmcvaW5kZXgucGhwL0xpbnV4Q0lGUwogVDoJZ2l0IGdp
dDovL2dpdC5zYW1iYS5vcmcvc2ZyZW5jaC9jaWZzLTIuNi5naXQKIEY6CURvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUvY2lmcy8KIEY6CWZzL2NpZnMvCi0tIAoyLjM0LjEKCg==
--000000000000ea5d4205e4525dba--
