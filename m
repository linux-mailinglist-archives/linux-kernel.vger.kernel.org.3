Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA13D5ABF09
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiICNDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiICNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:03:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E52BC6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:03:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p204so6806183yba.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=KamtnrZJze7gguw3h5znhehcXXj3T6EfyTceXIs/vDWXi//ktnwclL7whaxCLdxvuX
         HMOaeqhEljD3BebR73KvrtLsZishOfW8ZfrPdN0L3kN8dYniOuwH9bxLd9att0oJRhCS
         PjZEnePUuEPIAO3tKnv6kMfqVh1UbQsEJ2nslqE6X6qv74Qv8BAlN5UXwI45dYOvMW3M
         OgI58rp94MgdTW4gP2ns1vQ3dOGX5GhQKKMPz1EYiIrbJw808mipd+gab0j00aKspknw
         L4yVfmbfFqQhRRUnyvqn7ccBw6YXNDhgX8GM2mIFka3/fnh5hlDgGrBlXie6N6fREF1G
         Krgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=HA9X1cC0xZzFMFDo3V/MkpzrTGTDXKdDx+NC7OA5Pp3lza7Ez6mJqyOZlFbq+17Qq1
         9sJLIIOFeJ418Xfq2GJg3yLCDX/QAvlRWoqOTjVhKf9n9bxY7PtaklwuGSARHrwWoU5n
         DTgmriuxUJL5dnih9z5cHfSHiOHQovCdUAd1XhMn2vyOrFWBHnAQhA3ljed0yO3hKw5E
         0zauaDPNJ8HL45i1tyw6hhOdm/UrqT25Wc88wUV62Sa/5OzktuSF/xFDzrrxmvM6rFWE
         bZQ9tLse16P5hm7KalszKcc8+RCA4sTgyJgjebA9O2CkbmH/ctyCDsbjPrl3wlCM+pOB
         sZsA==
X-Gm-Message-State: ACgBeo3qY95fCOYSXZ/rK2BMFORQIL6O+G50XypoBN28dD4eX8o+rzEC
        nPgRVSrsyLyKinZbe/3gOYbUBeZbvDuXPYVv4is/QsAf7bU=
X-Google-Smtp-Source: AA6agR6apDi1a72NoiQxmBgqRYGtpq40riMieRPun24f+nPWuPa00m62da5Z+rbg75gzXRRCqln/HXCvBeDf9COXPu8=
X-Received: by 2002:a25:b790:0:b0:66f:7978:f166 with SMTP id
 n16-20020a25b790000000b0066f7978f166mr26632923ybh.17.1662210186315; Sat, 03
 Sep 2022 06:03:06 -0700 (PDT)
MIME-Version: 1.0
Sender: novnovigno12@gmail.com
Received: by 2002:a05:6918:199f:b0:da:277:ba8f with HTTP; Sat, 3 Sep 2022
 06:03:05 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Sat, 3 Sep 2022 13:03:05 +0000
X-Google-Sender-Auth: y9iip0H3Lcz2Ygw6hH2LS1TRWno
Message-ID: <CADVVueW8OaLccZGqMPKuGQStUH8pMmz37w5x5H6aTuyQDgdiZA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
Did you receive my mail
thanks??
