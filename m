Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D84C0B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiBWFP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiBWFP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:15:57 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B283D50442
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:15:30 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o5so6194316qvm.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=G63u4OKNMj8eNzKeIVpADNINRio3u60ure+LjTnbgfU=;
        b=Kz98UGCwqJywOSZm1WDP4Tsth1PPCZZbDL1DBQgAvEFCspQpkY1tlX7AOEkKNuRLtW
         aNkVZZEI7RArI1Hms2N3gquiGWmkwE5QzcPwlu5vGwsEiL1WrKVo4wiMYjeAirHvJGuS
         2MaZFVIo0/A9509KnS8xr7j436Fpu/iNcszt9rh4Z0LaBU22Kg/W5S/bEx/JWwLwT91w
         xiUV94U6C6uCEhonJGOpIoZqmfsFz62YH2SVzkGO/ICnaTm+Yh7/G1g1vTUEn6ydWnXa
         MNxBC53I1fwP6STWRWkc1Vmb6VFsdPGo3FHzIrwwU50BExmKeZ1oCm5eQI7eK4wFofsk
         U/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=G63u4OKNMj8eNzKeIVpADNINRio3u60ure+LjTnbgfU=;
        b=BjWJzq5kI61NR/0YMEIUK3uT8n4ZBn2aKjIpai9uI719u1jDQcB9EvWmaO3R2zvXeZ
         IaD1JQXgV3320jSw+CMIN1vDXAI/JhgiqR4VPxvgoBeBm6Gb38bjblg1wQvaHMItgV0M
         TmU2iVLt/yEw9Mjzgcf+tWpjMI/fymTLpFeAx8XwVBpolXN9SfSOgeu1HOU2OGt3dNgI
         4MVmhR8heHZS8rXmgSNTF9dMTEYa06Qa5XIrhraGltQBPuddkLXodFbmMffdWqC3/1aV
         fXxQtWzBrcGZt1QkifieUFhhA4yx17XYNKkxixjdJAEDmR38nzoZfCJMTimM/yEVLG4b
         WIdA==
X-Gm-Message-State: AOAM5334wgP8OyGRefpk/76c4ih1iam3rOo+F1Qicrz10njGp0Vln7JT
        exs9FaMpdDFJUvyAsOJjfcj9vuFg59utpXGNIas=
X-Google-Smtp-Source: ABdhPJxGA/hVip07fd4+x5LzRygu1wXLCAZ1gyGmuXPudTwcU+TJbBlv+K2+SEGZ5HaEqy29oS+T+Zv0euFbCbiWY44=
X-Received: by 2002:a05:622a:607:b0:2dc:e1e1:c3bf with SMTP id
 z7-20020a05622a060700b002dce1e1c3bfmr25090836qta.43.1645593329748; Tue, 22
 Feb 2022 21:15:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:80c1:0:0:0:0:0 with HTTP; Tue, 22 Feb 2022 21:15:29
 -0800 (PST)
Reply-To: gabrieledgal79@gmail.com
From:   gabriel <yacoubounimatou@gmail.com>
Date:   Wed, 23 Feb 2022 05:15:29 +0000
Message-ID: <CADJYvPMKVS=dghPNfOnCT_LNkNk+=0YMHfqM-WF=X+=BXGTNcQ@mail.gmail.com>
Subject: HOLA
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gabrieledgal79[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yacoubounimatou[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--
Estimat amic

S=C3=B3c el Sr. Gabriel Edgal, s=C3=B3c Auditor intern del nostre banc, vul=
l
us llegiu per rebre la transfer=C3=A8ncia de 9,5 milions de d=C3=B2lars que
es compartir=C3=A0 entre dos de 50:50. El fons es va dipositar al nostre ba=
nc
per un dels meus clients difunts, que porta el mateix cognom amb tu i amb e=
ll
va morir amb tota la seva fam=C3=ADlia en un accident de tr=C3=A0nsit. La r=
a=C3=B3
per la qual tinc
contactat amb tu =C3=A9s perqu=C3=A8 portes el mateix nom amb el client dif=
unt
i vull convidar-vos com a soci estranger a ser el seg=C3=BCent de
familiar del client mort, de manera que reclamarem el
fons dipositat i compartir-lo entre dos de nosaltres 50: 50 cadascun. vull
per tornar a contactar amb mi aqu=C3=AD a trav=C3=A9s de la meva adre=C3=A7=
a de
correu electr=C3=B2nic
(gabrieledgal79@gmail.com) per a m=C3=A9s detalls

  Salutacions cordials,

Sr. Gabriel Edgal
