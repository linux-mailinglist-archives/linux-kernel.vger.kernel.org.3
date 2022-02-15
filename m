Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88A4B7887
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiBOTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiBOTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:19:32 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD710CF0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:19:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p22so5268282lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rmAUdf26epsUhnZgVgaT/vfT/sOzQvVHgvDDTsajqPc=;
        b=LzChSGwlWiyeBElwd1gZsSPpenXQZzTrdlGvC7n8jlU4ooFZPHWMbW3iJ3PoIdFtfH
         3IKWBH/9XvnEGt5eBN5+IRYBE/KfA0HD5opmdcp+nxkxmUWEr8niPbFihhi5/wVdpP+m
         Os1aNEs0uyo/plpdIyc4f1UCQTE7yQlKlW20R3+8PFhd7BW2fUV7y3dWUaPUpaaA5bxh
         2ERVVfFMEqfqDBlTC6Z7/IFlRJ0xRjufnGsfFy6o3Da+0qUTQY+cTmk+qo8Pma6QrDsv
         aMC2FpRO2SjwIA1TvjpW7iSkZAbzWz/+UxANWzS6tbKp54Jo3Ko6i2weZPyUHI7pduyV
         bI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rmAUdf26epsUhnZgVgaT/vfT/sOzQvVHgvDDTsajqPc=;
        b=Z6ZptjR4U3Wf5S/G/oKTZRKEQyo1XeeK8lpxfkt3mFAkyDZ6QLM022CXVnA3G663gh
         zHWUSn2qiB25eIOcBFxqc63rWoktXRqSwh9s7pX7UnZFEFAzCLoILfXpCukdURTggM+N
         IIrPFby5u2pbzgDofV1PUW5lCn9WwYenw9/H6yjubhWW+femwZYoEfwJ5eeT4tHokOjV
         I4esYI965ipHLzbNFjZgUuH/9IWXo6GFi7LUYFxF5Zoc//zU6DGvbwsqSDFVgc1MFynJ
         VuKz58Y4qAgi7iVmQUwn/c2/7nbf+XlplNo9WpGNECsYpPgVFZWxyU03idJDsLPe9GYE
         31SQ==
X-Gm-Message-State: AOAM531PTUeJ/u3NO/kMPPimQNo1zJwaWFoFCI75XVN3CLpBfAp55EIo
        g2hPcT06f3byjU2XhpC3gYAkGXHCsLh5Gl5XZts=
X-Google-Smtp-Source: ABdhPJw6ey/cAYXCtsk6XJM8bxRhDwLiluuC8YCldEzucJ/f3QUHWKQdTd8q3Sx4laHkZjbW2prXlcqkSVqtWBsMXfM=
X-Received: by 2002:a05:6512:3fa5:: with SMTP id x37mr438427lfa.78.1644952760106;
 Tue, 15 Feb 2022 11:19:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a4b3:0:0:0:0:0 with HTTP; Tue, 15 Feb 2022 11:19:19
 -0800 (PST)
Reply-To: westerunionbankoffce@gmail.com
From:   "westerunionbankoffce@gmail.com" <jpaulesq753@gmail.com>
Date:   Tue, 15 Feb 2022 19:19:19 +0000
Message-ID: <CADMzAGybZ7K6thOgMy__tTUKghTJtBLttz2wTLcA0vRg6puWvw@mail.gmail.com>
Subject: Hello
To:     westerunionbankoffce@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        NAME_EMAIL_DIFF,PDS_TO_EQ_FROM_NAME,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
 Irod=C3=A1nk el=C3=A9rhet=C5=91s=C3=A9ge: 2554 Road Of Kpalime Face Pharma=
cy Bet, Lome, Gulf.

Ez a WU bank igazgat=C3=B3ja =C3=A9rtes=C3=ADti =C3=96nt arr=C3=B3l, hogy a=
 Nemzetk=C3=B6zi
Valutaalap (IMF) 850 000,00 USD k=C3=A1rt=C3=A9r=C3=ADt=C3=A9st fizet =C3=
=96nnek, mert
megtal=C3=A1lta az =C3=96n e-mail c=C3=ADm=C3=A9t a csal=C3=A1s =C3=A1ldoza=
tainak list=C3=A1j=C3=A1n. Hajland=C3=B3
vagy venni ezt az alapot vagy sem?

V=C3=A1rjuk s=C3=BCrg=C5=91s h=C3=ADr=C3=A9t.

Tisztelettel
  Tony Albert
  BANKIGAZGAT=C3=93
  Whatsappal, +22892905783
