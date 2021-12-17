Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5C4795EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhLQVAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhLQVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:00:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:00:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w24so2860144ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1b5bT09WRsnvuEPuF1IFjBQKMQysbL642q4Zf90h6hw=;
        b=Enjq0pll3Thex056gMGJjR1kxbgfOwl43m5tLV6pzmuxi5QB4UTJe9L0Z1RmYsVe16
         bQeahjDh8VCdgdqY6W7qetIUvAOZxDGxBP0vmEoMdfMSIT92Gtfu8+N6eC6qp92tCg2Y
         KqsKuWu2uhtGWl78e8Mvz1CbDs3+j3Z0J+EC3KGpY3H4O6IvfysvoQ5nGUjn6Rgtzah8
         K9og72sqkRr+4BpDg/bFRzRJ8mVpTYXATZGuLvarSvMXbLYqq9icqEfbDlFwrWys1Ugd
         dYIsM2HWhHZRi65RzqLkYGGPE2x7wTkHFTxfX8mHMdvpUAD1CUawruxzfKO3X1kS216D
         NG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1b5bT09WRsnvuEPuF1IFjBQKMQysbL642q4Zf90h6hw=;
        b=KBy5CF3wVPRz6wNH+kD3bis3QbOfd/10mqqfLTaFBAkaHPSxj6eGjvAGT3FHhtBHVm
         Y0O147qfV+8+fNiCc3yBqESxycPZ6B/Vxnu+4pC2ZNdGmM10B7UCzo5SZx++BkWP/e8k
         K25Zt4FjH6XK3Y6CJf0TYB1v/fG4y2B2fJO3VLfWJDOlbOaB6vXDlUTsKP0wtFoZfgyV
         LFLRjpZ8Q2Dq341tbIZFCenLQz0DBhqrT39ME3oy/QnbNnEfD1yv6qpum9zKhPkzoYY5
         Gd3o4VC2oWbEoY6XsWUvKsRKDDnTKBGs93Zoz51QS4WmTmpG2h3m2dPNB6cEctcHfNeg
         CMow==
X-Gm-Message-State: AOAM531Fs0x1ZHGP9196B+BSlpie6Fz/RVl+yvwr2kqBP2i7B8R1NJvk
        fei3Rwg5TMfaTznKxh6FvulFEHNypztyPU+xnOs=
X-Google-Smtp-Source: ABdhPJx4znRjGE3mwJnqFydn4IU0FsLE2VcUUxdR4BLcb1lAcn230JrZDS1gsTpr1VE0h5XJVLNsQhqlL5a2YsVYwIY=
X-Received: by 2002:a17:902:9697:b0:148:a2f7:9d82 with SMTP id
 n23-20020a170902969700b00148a2f79d82mr5065403plp.161.1639774823113; Fri, 17
 Dec 2021 13:00:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:5154:b0:5e:c513:fff0 with HTTP; Fri, 17 Dec 2021
 13:00:22 -0800 (PST)
Reply-To: bankdtb160@gmail.com
From:   DTB Bank of Tanzania <efffbi12@gmail.com>
Date:   Fri, 17 Dec 2021 13:00:22 -0800
Message-ID: <CANLFAeSGpsMQ4FZJuNuVGqE80ECOPDoNc0Fr4c5YiuvfXa0Gzw@mail.gmail.com>
Subject: DTB Bank of Tanzania,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We write to inform you regarding your inheritance award winning cheque
of $2.8 million USD which was issued out from DTB Bank of Tanzania
last
week, although the cheque has been cashed & converted to ATM Visa
card, reason, the check was cashed & loaded into a card is because the
cheque
may get expired before it gets to your possession, therefore we have
to registered the ATM card with EMS SPEED POSTAL SERVICE company here.
So you are advise to contact DTB Bank of Tanzania through
E-mail;bankdtb160@gmail.com via their info below,
please be sure you send your current home address where to deliver the
ATM card to avoid mistake or misplacing.

Contact the Manager Mr. Abdul Samji
The Executive Governor Of DTB Bank of Tanzania
E-mail;bankdtb160@gmail.com
Telephone:+255 8983 0023

Regards,
Samuel Brida
