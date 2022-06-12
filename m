Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A9547A83
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiFLOhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiFLOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:37:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC8DE9A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:37:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c2so5333800lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=SXNtflbLhDlSSkCBjeccWDJUo499sA2fnD93eSUPHUtyy8WqxitKkmPy69qLz3c126
         MiXFSTC1GPv2T3uw4BF/Xvo2km6ry17i0P01EuJGtAVNOcvPShehKfcrRTVpnQ29X9gb
         kvpqNOm8MijKRlfUIg/YT0cHWyaDjKNENNs1/NexEco59a6JC3z+duJIUDuOLd3mHlH/
         oGo0w0pb82TVmtVhD2R2H5opzLj1QsldniFVDa6hWdVWz10+usGTl0fw+ao66IOBs6yn
         JfLNUOjvTey/BhBohzYjyplPBh5V9+jrdYRJivE36Ub7rkxfUNVyEzwc8+RBNzxx7xcy
         2MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yHYbw2bx/nsQBLFF3gJlg+vRlUz37DtKoW4ftjnCRHI=;
        b=icse1vKsnv04+51cl33qWqMNBrGWsunbPyuglAvhPmbeWk7bev1XuQctgnKOreeUvK
         7yGU1RDD+Z1EDNXxLMNatmRAc57taUobiJUnT8S8BK5ushM8WpQlSNqq8ids8g1q0nhj
         XkuXtlLpG8W66BGPg9vegr8P949Zkp8lDUlO8A2kAJ/k1hKhgAr30wA8J6uLjUqGlve7
         0JAaw6+aPgdNjO63I8mY7cds0Y4pT4B4zCZuJKhl8PSpMvs1jCtd/JU5bDtEmRDKPNLs
         +25ba1jNgd5jnkZS6TekYH45yqovwI3XABspu/ToZ3uXVdsl4syNpxlKvyy0oRLQ0C2V
         Oaeg==
X-Gm-Message-State: AOAM530ZKLFZKQhRcTNZ1ZFoNBR0t+avA2eNwgu1+6/lpwYvpSoQoS65
        2CgqJJfyvyrB0d1Mn+D3Ij662WEHVjaciKQ07tk=
X-Google-Smtp-Source: ABdhPJxTDV7yjm71q3Kj0qcR5wRO0uaemB366Lcof8jweYgwI+W8+iuTvVoTPSqiKsGBnh85YjWnm2xImkx086ESNEw=
X-Received: by 2002:ac2:4d11:0:b0:479:4a96:83ec with SMTP id
 r17-20020ac24d11000000b004794a9683ecmr20949328lfi.517.1655044660108; Sun, 12
 Jun 2022 07:37:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:16c7:b0:1cf:b763:cb85 with HTTP; Sun, 12 Jun 2022
 07:37:39 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracymedicine1054@gmail.com>
Date:   Sun, 12 Jun 2022 07:37:39 -0700
Message-ID: <CAGc_diXpeqiA053g1CUUtSHx2JQ1TdRu-CL0jB17VvTKDTHvqA@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today
My name is Dr Ava Smith,Am English and French
I will share pictures and more details about me as soon as i hear from you
Thanks
Ava
