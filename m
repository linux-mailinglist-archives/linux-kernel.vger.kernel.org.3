Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A493F4758E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbhLOMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbhLOMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:33:05 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CE1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:33:04 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a1so678229qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Up+NWP2zXS/W6YKEfOGmNTkWQI2VP9qpgkzgIEJR3fRyz0l9TsYGUw1qWQ/Nkdnetj
         SfBGM/fZHSUIlynR1CAW0epKL71TsQ/xFhW5+F4xxu8gYu/jpqcELiFBFrIX0aVSbY/d
         QggGh1b+tWHCS4KeaB6KXVKCJkDSPfrMOam3aI1xiLbURUtak+O6WyBKGhwaiQTb0KuR
         N87o6xAIAUCRycyBnMS0Q8mnXCQIY4PB02+fHYzF+uZfM/KYI0+3IUU9EpAJoPX9qGvW
         /xghh1c0XbreShCzPcRtnFd/wzw5HaUstLNvLg5MxSRr2hKs6tUuWsHIMd4H18SSwIGN
         A3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=vsD59+4QA6SYGz7Tii8PBH2o8IkHL+iCmMP04k4ch1c1Apcq2TQrkOpeFjLmX9zoHm
         iD9NJA4WpsFILeNlXq9BoKD7Rp98qn/Cw3aiTrlAiDO9SMI6zMxOifKnp3/t9mv0Wi4q
         0btc6AG8rT2pYDg6tT6Cr6yU7xgk4LFrUEq8I9Mbs9DKcaoXgfuPt/t+Bw7YFatDn3og
         fgz8f4Tsjnnkx81ULfJ0jbcX+UelkQAhsHmPZOlMFVoWhGKr2THZZu9IenSJXc6cTaaW
         zwJzuHid8zDpCa9M5UTK0tfyBsdk2pamqKCtQ+v+w0DoQB07Zz02pQh92gvez0nSS13J
         3KSA==
X-Gm-Message-State: AOAM533FKcg6VblakH7mzqf+n62IYNV/aw6CIrt5cqz3ocGMCuoeZqEi
        5aGdFYgLK3PGXsJ2prvUhKtWqKxF46YIvmwwSbg=
X-Google-Smtp-Source: ABdhPJzr2dK+4tnPmejLzH/DTnnRP88EPeCUCvzzOZuzRZ1tC4izYn0Q3dOt9RQaE3N57zNz0pKgYzG0t8dGydnhv3M=
X-Received: by 2002:ac8:5947:: with SMTP id 7mr11557283qtz.16.1639571584056;
 Wed, 15 Dec 2021 04:33:04 -0800 (PST)
MIME-Version: 1.0
Sender: yaoelommodzinukuse@gmail.com
Received: by 2002:a05:6214:252a:0:0:0:0 with HTTP; Wed, 15 Dec 2021 04:33:03
 -0800 (PST)
From:   Daniel kodjo <klawfirm02@gmail.com>
Date:   Wed, 15 Dec 2021 12:33:03 +0000
X-Google-Sender-Auth: 0qjc_UZlO8stB2k6SsyXz3DbfvE
Message-ID: <CAJRYjFRPpiJK8rXLNnUs05nFB1N3OoAvN-BPsD=jAP6MnJQYgA@mail.gmail.com>
Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe=2C_wie_geht_es_dir_heute=2C_hast_du_die_E=2DMail_e?=
        =?UTF-8?Q?rhalten=2C_die_ich_dir_vor_ein_paar_Tagen_geschickt_habe=3F_Bitt?=
        =?UTF-8?Q?e_melde_dich_f=C3=BCr_weitere_Informationen_bei_mir_zur=C3=BCck?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


