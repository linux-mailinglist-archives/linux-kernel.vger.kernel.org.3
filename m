Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCD4D5322
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiCJUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCJUhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:37:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C42A136861
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:36:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bi12so14760920ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Kn5wkjCWILkK7hGonOplEH5Tc0x+YfyRPzvbgH91/Vc=;
        b=qum/jIXKdgsYJenCmrQnq1+F1nxO/gk/3addou35bfpinJvLbc/13YHQgdg+nlLVHV
         LN3jm0CRg/H09X2ItPMaYZ5lvMs1lR1LsJFYH+2QwPSeTkUYLmpv5mAU79nrWTDlaJkv
         fut6aPhQL9CxJySP2CA3Df1ihJZMC68kWbFGjugUWc2VacWXfGXkitbI/TEiBd0D2T+0
         tjBW2woLVN958VRSBzf1T1kx+rCAvisxeIR5MboyxvpGmlZVLbPagvEu+p4qDUyh1guq
         6azG2olqojRbRux5F5AglJPqGU74guVKxAM3ZEE2oAsBJNnDOF3hiJg92XUpYjs66l2N
         XwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Kn5wkjCWILkK7hGonOplEH5Tc0x+YfyRPzvbgH91/Vc=;
        b=CGLJAsV5Zrn1SEWgaI4/LGGkcBnwQ2v6Q7Fo5R+qKovoCZaBndR4pyvgKERFpbeTDM
         9PPEwkiv8WlkoydI9BkPtZra+sF3aNl/PRE1Hey/MaRQHnEYODCEM+5QMQzN6CGIxLC1
         2XSvRjx9elyPQc1ZKPUt2dkmOkpfieBG4aV25gIaG2HdvVbQQHf0/vG3pJxtCw11WKZ+
         0r6G8uPq4sWtT29k3M+1JG6bZ11xSXRsHhe33oUmBR3avlUbXPFL5+oQJWxBIeQfpQ8g
         CEIAMgYQNwi3TUp/iqwukaaCso04jaS0bNNEjXXPT99TIJPAN2lJ6HPWFfi2PacjYPyP
         hUqQ==
X-Gm-Message-State: AOAM532z6YxoED75l1xUWdKJsK/HX0W4l4UOaq3IWMhm1NkOFYnfwyOG
        ERroKY9E3alZejNDGT3nVkBXH1MciTCGepuRmr0=
X-Google-Smtp-Source: ABdhPJwTqrpou2mz+kCnhm2yIJePPUG04E4JVTv+xR1BGaPwvxGHf7uNbT/E5Zf7NOjd2+qckNWjVyknOGCfI9/JSd8=
X-Received: by 2002:a17:906:57c1:b0:6d6:da73:e9c0 with SMTP id
 u1-20020a17090657c100b006d6da73e9c0mr5921002ejr.45.1646944595735; Thu, 10 Mar
 2022 12:36:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:384e:0:0:0:0:0 with HTTP; Thu, 10 Mar 2022 12:36:35
 -0800 (PST)
Reply-To: westernunionoffice087@gmail.com
From:   samson john <samsojohn2@gmail.com>
Date:   Thu, 10 Mar 2022 20:36:35 +0000
Message-ID: <CANWAvMiAVWf9pYq6bMMtUzXYvL3W7qvGF48XV_dTpTtfBPdzqg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [samsojohn2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [westernunionoffice087[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [samsojohn2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zpXPgM65zrrOv865zr3Pic69zq/OsSDOvM61IM+Ezr8gzrPPgc6xz4bOtc6vzr8gzrzOsc+CICwg
MjU1NCBSb2FkIE9mIEtwYWxpbWUgRmFjZSBQaGFybWFjeQ0KQmV0LCBMb21lLCBHdWxmLg0KDQrO
pM6/IM6UzrnOtc64zr3Orc+CIM6dzr/OvM65z4POvM6xz4TOuc66z4wgzqTOsc68zrXOr86/ICjO
lM6dzqQpIM6xz4DOv862zrfOvM65z47Ovc61zrkgz4zOu86xIM+EzrEgzrjPjc68zrHPhM6xIM6x
z4DOrM+EzrfPgg0KzrrOsc65IM63IM60zrnOtc+NzrjPhc69z4POtyBlbWFpbCDPg86xz4IgzrLP
gc6tzrjOt866zrUgz4PPhM63IM67zq/Pg8+EzrEgz4TPic69IM64z4XOvM6sz4TPic69IM6xz4DO
rM+EzrfPgi4gzpHPhc+Ez4wNCs+Ezr8gzrPPgc6xzrzOvM6sz4HOuc6/IM+Hz4HOt868zqzPhM+J
zr0gzq4gz4TOvyDOs8+BzrHPhs61zq/OvyDPhM63z4IgzrTPhc+EzrnOus6uz4Igzq3Ovc+Jz4PO
t8+CIM6tz4fOtc65IM67zqzOss61zrkNCs61zr3PhM6/zrvOriDOsc+Az4wgz4TOvyDOlM6dzqQg
zr3OsSDPg86xz4IgzrzOtc+EzrHPhs6tz4HOtc65IM+EzrfOvSDOsc+Azr/Ots63zrzOr8+Jz4PO
tyDPg86xz4IgzrzOrc+Dz4kgzrzOtc+EzrHPhs6/z4HOrM+CDQrPh8+BzrfOvM6sz4TPic69IFdl
c3Rlcm4gdW5pb27Cri4gzqTOvyDOvM+Mzr3OvyDPgM6/z4UgzrjOsSDOus6szr3Otc+EzrUgzrXO
r869zrHOuSDOvc6xIM61z4DOuc66zr/Ouc69z4nOvc6uz4POtc+EzrUNCs68zrUgz4TOv869IM60
zrnOtc+FzrjPhc69z4TOriDPhM63z4IgV2VzdGVybiBVbmlvbiwgRHIuUGhpbGlwIFVkb20gSnVk
ZSwgzrPOvc+Jz4PPhM+Mz4IgzrrOsc65DQrPic+CIM6zzr3Pic+Dz4TPjM+CLCDOvM6tz4PPiSBl
LW1haWwgKHdlc3Rlcm51bmlvbm9mZmljZTA4N0BnbWFpbC5jb20pDQoNCs6pz4PPhM+Mz4POvywg
zrrOsc+EzrHOu86uzr7Osc68zrUgzr3OsSDOtc+AzrfPgc61zqzPg86/z4XOvM61IM+EzrcgzrTO
uc66zq4gz4POsc+CIM+AzrvOt8+Bz4nOvM6uIM68zq3Pg8+JIM68zrXPhM6xz4bOv8+BzqzPgg0K
z4fPgc63zrzOrM+Ez4nOvSDPg861IM6zz4HOsc68zrzOrM+BzrnOsSDOriBXZXN0ZXJuIFVuaW9u
LCA1LjAwMCAkIM63zrzOtc+BzrfPg86vz4nPgiDOvM6tz4fPgc65IM69zrENCs68zrXPhM6xz4bO
tc+BzrjOtc6vIM+AzrvOrs+Bz4nPgiDPg861IM61z4POrM+CIM+Ezr8gz4PPhc69zr/Ou865zrrP
jCDPgM6/z4PPjCDPhM+Jzr0gMyw1IM61zrrOsc+Ezr/OvM68z4XPgc6vz4nOvQ0KzrTOv867zrHP
gc6vz4nOvS4gzrTOtc69IM68z4DOv8+Bzr/Pjc68zrUgzr3OsSDPg8+EzrXOr867zr/Phc68zrUg
z4TOt869IM+AzrvOt8+Bz4nOvM6uIM68z4zOvc6/IM68zrUgz4TOtyDOtM65zrXPjc64z4XOvc+D
zrcNCmVtYWlsIM+DzrHPgiwgzrXPgM6/zrzOrc69z4nPgiDPh8+BzrXOuc6xzrbPjM68zrHPg8+E
zrUgz4TOuc+CIM+AzrvOt8+Bzr/Phs6/z4HOr861z4Igz4POsc+CIM+Dz4fOtc+EzrnOus6sIM68
zrUgz4TOvyDPgM6/z40NCs64zrEgz4PPhM61zq/Ou86/z4XOvM61IM+EzrEgz4fPgc6uzrzOsc+E
zrEsIM+Mz4DPic+CIM+ALg0KDQrOpM6/IM+Mzr3Ov868zrEgz4DOsc+BzrHOu86xzrLOrs+CIM+D
zrHPgi0tDQrOm86xzrzOss6szr3Ov869z4TOsc+CIM+Hz47Pgc6xIC0tLS0tDQrOpM63zrvOtc+G
z4nOvc65zrrPjCDOvc6/z43OvM61z4HOvyAtLS0tDQrOkc69z4TOr86zz4HOsc+Gzr8gzrTOuc6x
zrLOsc+EzrfPgc6vzr/PhS0tLS0NCg0KzrzOtSDOtc66z4TOuc68zrnPg863DQpJaGVtZSDCoEFs
ZXgNCs6UzrnOtc+FzrjPhc69z4TOrs+CIM6kz4HOrM+AzrXOts6xz4IgTE9NRS1UT0dPDQpXaGF0
c2FwcDorMjI4NzAwNzc2ODUNCg==
