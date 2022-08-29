Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51D5A5207
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiH2Qn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH2Qn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:43:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542273923
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:43:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m2so8180723lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=iV+tGHitMbQ1j6mk6mC7qK6hokt/utgy/q3ojU2z20Y=;
        b=EpqGgeLHKyIlVbJrF/HZzM19cDYt12y6LDPlkVA0ceQW/55/dIz43fkTTmvCq0E9VD
         d9/YlirE/dKo5n+Q1b1LBKvPh7HFhgDrFoANNXBDmMprT87ghTcJ6Lor0l5GeHDw5wT9
         +FVORn5Eur/tBS0DtMEXy0E/xCqpiarpNzUeUxO9y7zDU6UgYm4xS9YIPOOzzK3AdWX9
         8t/YlfNIruv3L17ObjBc/khlxdl+baufN2hVQayvTmrNuZ5C54/WYrkFbWvJfBIuO3Gi
         4h588odRIf+BuV0wRgtYqu0SK+9H06c1aqGBb4zxu5z0kSRMB1oBoBY2vx3tzWdPtiKN
         uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iV+tGHitMbQ1j6mk6mC7qK6hokt/utgy/q3ojU2z20Y=;
        b=C1FqNfD6JjLfK34H8BG4epSS6Osl7xvM0o92M/iFfC38+cdInMwXH4dqyqjeIaO6J6
         VCTUvOniOhGx47MZoU9AFWhs8N2VK054JznCaTcSzKF/4zH31XQPAtcpdwHvoEgaA/RE
         6vc6IAGDtHsoZJ0f7iwZ7vuxxDiQ+etpDILonI9rdCtwvkpVOBl80xbiWeMNm0Y4KkP8
         Vdz1JhQ9E8pwRaqAM4aPqWWPJqLMajGDeGgb6GyxwQq8Ca5RMO++JfiZ2scKZil3CiiR
         OB9SLBP5HRPbJv4Cx7JoJg7twSqS2poK/PbzumK7c47DlcWqHzaOCILUWFq+s0t6C9uM
         EK6g==
X-Gm-Message-State: ACgBeo3PYrNDcx76aZo23J2LwTlvMuCY5rR5J0Rq0A+sbN0b86b8DaSY
        Ogv+4wIySNnICfKCEvfciPdQb97z/jdWuVh4f0w=
X-Google-Smtp-Source: AA6agR7et66RhuJAIYMbh9EKJm8j+d6SlGeUlPK2j/v2mLcLry5f65sN+ZgyAect3BJwT7dszdIJH00zGvy4vm4RQOU=
X-Received: by 2002:a19:dc4a:0:b0:493:e21:b77d with SMTP id
 f10-20020a19dc4a000000b004930e21b77dmr6297272lfj.580.1661791404129; Mon, 29
 Aug 2022 09:43:24 -0700 (PDT)
MIME-Version: 1.0
Sender: adamn9496@gmail.com
Received: by 2002:a05:6512:2810:0:0:0:0 with HTTP; Mon, 29 Aug 2022 09:43:23
 -0700 (PDT)
From:   Miss marybeth <marybethmonson009@gmail.com>
Date:   Mon, 29 Aug 2022 16:43:23 +0000
X-Google-Sender-Auth: SsraYS3Q_Uz8x0v62ZGACVqYf-0
Message-ID: <CAM5gNcVABE1fgHTr1gn_fEnrCtxkExqRveR59chPLJbq+Yki1w@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Szia,

Megkaptad az el=C5=91z=C5=91 =C3=BCzenetem? M=C3=A1r kor=C3=A1bban felvette=
m =C3=96nnel a
kapcsolatot, de az =C3=BCzenet nem siker=C3=BClt visszak=C3=BCldeni, ez=C3=
=A9rt =C3=BAgy
d=C3=B6nt=C3=B6ttem, hogy =C3=BAjra =C3=ADrok. K=C3=A9rem, er=C5=91s=C3=ADt=
se meg, ha megkapja ezt, hogy
folytathassam.

V=C3=A1rok a v=C3=A1laszodra.

=C3=9Cdv=C3=B6zlettel,
Miss Marybeth
