Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E347FDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhL0OSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhL0OSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:18:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 06:18:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso8466020wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 06:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=OjoW+5pu3o3FDIOdybxvvUEcJwrCmfXmeR5TSdm0klxKheZsEqjC3CvgPR8Vmm8Dxe
         Ps4xlnbP6fExeVz9fPZvUihpUTZ/6ArQdQ4Rq3ihX1M+EporCYxF4EFD1uTPJ7seg7dd
         3vktosjKLqz4POgCaZcV15imrkXvHiX854tYhBzeSD4BbuPQcnQLZBRD12kbeUK1oRis
         QSk/mlew42i9e1DoOgUfh0NcNN2Q3/fEo8c+yqipAC37GNSwY4/B29E9C47qOLGrcFp2
         r6hK0Tw5ldzWin9Y+cBUabtJAdweoF5IbJS0QDqClMkWHSOi+8MuNVH2QaY9TrmNx4ds
         WFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=oCMlLt3Gft25AjjdQsjeQ6WgqdgKmPp0beon2zi3YddOs6L9IMVBJB2Xd47lRSAgBk
         2FNbv8X1DF9w8v5imxXDeb/LwTpfvcR/4d95dzfbXco9bZgRuhm1ERqOeiPx2TX4fjdK
         qnjtTNLsbhS3Kcuza2W5m/6y1AprUux4uWGeFc/6bdtyCDx6AZbi7he/53h1rfUmye4h
         dkrObFT7ltuDkceNNCzaVoIbwm9LWtN8Lz/dxkcAmeT0TPA0iK2BLr7rxhjSV3OkOYo1
         s6M6v/BTZy+KWcV642NX+lfknXhO8dKkOw4ql5vSNIJ7SRsFDpl15jM0XDWWT922/c0N
         DG7A==
X-Gm-Message-State: AOAM531sjf9gaX7aefwibWSTknJaaGsY9sk/78Y8HvhiB1DiRmZ6c/F9
        3NqulddLWMuBzZJv7Wiq4ysSLRURMok5agpVJjw=
X-Received: by 2002:a1c:ac46:: with SMTP id v67mt9590571wme.182.1640614692944;
 Mon, 27 Dec 2021 06:18:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:5585:0:0:0:0:0 with HTTP; Mon, 27 Dec 2021 06:18:12
 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAO8vqiswu3wTv8HuK9EBhXdhQHGa2aTiS0MkaUbutDdZOtbYSA@mail.gmail.com>
References: <CAO8vqiuwU_gUtLQepOYwW=bOC0mx3UiEjUu+hCogSggXeUZ2rw@mail.gmail.com>
 <CAO8vqivhU8ozpGh379-Z9LTdsQr02r6P_QbBrHUEAyc5BH-ykw@mail.gmail.com> <CAO8vqiswu3wTv8HuK9EBhXdhQHGa2aTiS0MkaUbutDdZOtbYSA@mail.gmail.com>
From:   israel barney <lmuna521@gmail.com>
Date:   Mon, 27 Dec 2021 15:18:12 +0100
Message-ID: <CAO8vqiuorSw4dijerBOGnYqed3ZZVFS4r64dJJkO0HYKGcZ-aA@mail.gmail.com>
Subject: hi
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit I talk with you please, is about Mrs. Anna.
