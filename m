Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09588524107
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbiEKX1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbiEKX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:27:31 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62167692A5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:27:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-edeb6c3642so4747989fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=DAiU2hLgyS60pnPi6Jv1/IUeCvRc5Y5l7hcgGiTBtkvK2poEADbyUE/7Z52kA+tI8m
         Elhyf/e7FN7n6wVCE7ls0N5fuo4D4sPvcor6mrmUgW4DHtpd9AhyXg3E6T12glWoR7A9
         0PaGXOYJCUtRqIfJ2zpmgbXDntppH5U87WWTSmnvF68xnhADe/Uz2JSwDCKqdkVv8JRy
         aKPXZCezLOv3InRT5tzBFwfO1+K3LOrggURFMqrRJKKaVtkxpHuvK9e3GbRAvEcD/Kd2
         IOLL77ppmk2aa5lbPNEl7DCNDt+w3yefwFV/HpZDBLPVBg+x+9l0EOD3yUG4QmCRtX2v
         kYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=ZSoUlf0cPEpL7jjk6Nyt81rsCpO1vJSuE6CFnE/F0mc=;
        b=H11cv5uk2AxCWEq5+ReR22XoXYjByPrUwoE7wupZVK8QqTmDyRPVDJoj6gT+HHDBoK
         EVyAoD5tHMy7RBhVHtU4Rb0BzYCYX4F5c+f2ArQIZfckBoSDL3zS8YX0Reas0K3ttkC1
         kQ7fLgHLlskgyIIaZdrGH2Xdl5j8cUHGo1ZYH+2cnfXeG2bkdouXWTpfS94E2IzbqrSD
         QggKsdarRuuLpBGB0GDZzLHYNZkHiNatFMWnye2IVFOb4yh7/+2XZbMKV//fXHdAiuJ0
         NMnv/u53iZhW5G0SUw+/EEUWa9oH1EQcZFrI0uSTw5jPDAfPnS3E2po0CKj4HVh7cOPN
         HfAQ==
X-Gm-Message-State: AOAM5329mynstKltBjFY2Vy+d7VX3Di5l/JHfwRdaHGBGsqPjgRqKy3S
        U5LPlopvxMPiFGvnL1T4QDrzbNLUVz1tTB5IOM4=
X-Google-Smtp-Source: ABdhPJyjS7z/AwKL9dWOwhoFjrVKjLy+IJ/lGY7Nc8KnzICMQMATks7TORKRg1z6KbuyXhjvgU/6n/DIySqhAmVmr5g=
X-Received: by 2002:a05:6870:7084:b0:ed:d709:34be with SMTP id
 v4-20020a056870708400b000edd70934bemr4015822oae.4.1652311649788; Wed, 11 May
 2022 16:27:29 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsivvonedavidabalakiwal1@gmail.com
Received: by 2002:aca:1010:0:0:0:0:0 with HTTP; Wed, 11 May 2022 16:27:29
 -0700 (PDT)
From:   Frances Patrick <francespatrick49@gmail.com>
Date:   Wed, 11 May 2022 16:27:29 -0700
X-Google-Sender-Auth: XQ_o5zoHSwe3gCg2D_GKX9nxNmA
Message-ID: <CAEc+UiPeMqyjPdTD=n=B7hACNMvvPRhM_VrV5tAzuXbwkvir-A@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dearest Friend,

Two Million Euros has been donated to you by Frances and Patrick
Connolly, we are from County Armagh in Northern Ireland, We won the
New Year's Day EuroMillions draw of  =C2=A3115 million Euros Lottery
jackpot which was drawn on New Year=E2=80=99s Day. Email for more details:
francespatrick49@gmail.com Looking forward to hearing from you soon,
