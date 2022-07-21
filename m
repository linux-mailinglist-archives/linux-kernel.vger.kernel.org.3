Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42FC57C90F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiGUKey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiGUKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:34:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D049B68
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:34:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31e1ecea074so12344027b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=pAv2uvm8AJ1VyPTcGWTCmrcD+KQzAjTV8rgacFCdLNgEoYhtZf4R4S3Xa5omL2Dp0C
         0beuUd1jAQg6A4oUyDlIJ7akUVkVjyFI/pJRTHaJux4Vybn6w/89HG0fLpjNog8xmH3p
         1O639kvK2H80xC+WGzetFzAFghu8RiEVK6CGZ56ExIdlg85iy/7Kf4oEbK8BmHNfVuYW
         bqLxEnrTsvSd4kgXey5h1hhswPiSc8sH8+98lBjM/6v0foJW8Y19j6Fsenu266suy2w/
         3R/M9qDu2T98P9bHxyCGn/BlDUQGpPGV+T18t136eaGX411ZNDtRh2mSSXfc1NvMmJEn
         eb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RZq7zJW68AsB2c8MQdTOdMV2RE0j/waEnaPxwlHywbM=;
        b=xHPmOpSBXsG/Dvv+mQyq7Wilah3f1TmdAMUJmgY5TLUGaOvLENh0NNdWRxXuSd0BQz
         q7N74RvmV+8XfvLwJCuDNbhb8PZWM92guyZvAISEwISwO7A/loN48CLevZmkdbpGjJP6
         CCi6at2r1Vku1ZyubFvCvuWipwgxRoPemuRRhzMpXr1/9gexd2K/HCmMyRfO2iSghHPE
         eWx3nnEzsq6riw2Ns0nNxiTB10hJud9lZoQqELhdJp+DVGwbM5DU8PhiejTCO3+JugXg
         iA1kBEsFm/3HIlAMHfoyHcE0eW4wVtU29Z1cQRe00bpT532lhD3K5f6HraoVIoS4RrXU
         LcSg==
X-Gm-Message-State: AJIora8j3ujzCMZEeCAaMPQzCUY/eHfZn9ICdOyrFTCBq5jw8eFcLrmU
        C7b/VlhydN3yNqUZpvWofk915qKZ8vholQTDcwY=
X-Google-Smtp-Source: AGRyM1sSn1BkAWY+mB4ipMJAHZFCKaVocMYpWA13ZykYuFlMENH68zd3kb0uUYUhJRdQ/UEUdH98A7DEqZZkjmF+Pew=
X-Received: by 2002:a81:234e:0:b0:31e:2cd2:624f with SMTP id
 j75-20020a81234e000000b0031e2cd2624fmr20702507ywj.516.1658399690236; Thu, 21
 Jul 2022 03:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:a514:0:0:0:0 with HTTP; Thu, 21 Jul 2022 03:34:50
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <tchaloelise@gmail.com>
Date:   Thu, 21 Jul 2022 04:34:50 -0600
Message-ID: <CAObQroXHJ+D5GKJ9q8RF3P5NCdRTvP15XvE7suhjR6Y4QfE2gQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? write me back
