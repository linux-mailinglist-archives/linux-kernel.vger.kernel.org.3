Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCB3478B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhLQMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhLQMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:18:15 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:18:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q16so1907958pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PgAQMoF3FxS7poQ4mxvqYG6svwwslz8uWPPj24m9se8=;
        b=Iofd42j4mTOfr0SG+Evy5gGD5mw+5PXFf2rxKMxLAn6HcrjQB/xGKPlYZw3PMWJS+4
         c12KQ5Eogt2y6DsJpyo1VUieWzFjUmq1PjAutPukvsTn3nWth5Y+2Fy/+stobWMz/U6E
         87Ml2KUdWmM9b57NNN0KzIlStoXlKeCHKHtO6f7K0SUMrdVWt7f1uNYZ0RPM2WjEPYCl
         USFoc4+BBOMm4TbhaZVNKlCopODsxDOhgtYXxQNOSWDFObeIlE8K9BU3N9GI+dNeSAA3
         wfn8aO9MWb5MYO5Qt8mdy28bMnESuJWbMmAqpAaChEHb4MqO8Jl2IhO6BKKRcZhVx9oh
         gaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PgAQMoF3FxS7poQ4mxvqYG6svwwslz8uWPPj24m9se8=;
        b=po/l3X6GQ0Bj6OfIpyvhu1cTZ+cx7YukacQmbTFQayGhR7JzGGimy1QsSIMYZRO6+y
         O6B9RuAUanZ8SU61uTgBhy2zNHgIcPr/JHI8P3X9BLt3izGbqLvBVEu0y9aXL10WYxEj
         MsUWudtoncbDeN96g6drmTV+RxZhK38wFcoQHE5XxvSP9CmMw6Q0HlKgE5COxURrDuV1
         JJnUyVuV0kS+M8S856V39Tc+lsl/vEQ4DL/YV+a0WWldULYZF3sOgcDtuOlS4xf26gzP
         Chk23UWHDPbXZaB7LzcjK4FuOO8MGffDaeFD5E/Ybv/SuOGaw5b9kQ8eiWqHbo1riRtK
         UtGg==
X-Gm-Message-State: AOAM532Yl0alMMhmZrJYL+eRuBwHaruKhyb+g+VAMfefLOD9K/evT/Yz
        HrOudobDuEkxkxHVWb0QFgsJ1szP4BzqkOai1/A=
X-Google-Smtp-Source: ABdhPJylU40kUwGUIr+LpOSZLJp1W+S1gJU/w3SokSll/EKJGwPkgmpVkEgMvb5gLdSuUNeO4i+q7ICiMZIt0aPEUbk=
X-Received: by 2002:a65:418b:: with SMTP id a11mr2671509pgq.620.1639743494651;
 Fri, 17 Dec 2021 04:18:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:cd15:0:0:0:0 with HTTP; Fri, 17 Dec 2021 04:18:14
 -0800 (PST)
Reply-To: johnjake628@gmail.com
From:   =?UTF-8?B?QnJ5YW7CoEpvaG5zb27CoMKgU2NvdGlucw==?= 
        <veronicegbenou@gmail.com>
Date:   Fri, 17 Dec 2021 13:18:14 +0100
Message-ID: <CAKidhb+YZwqtrLjJgC1rqqmDfjTWmLnfSFbR03_1AakpS5_KLw@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have you received my first message to you
