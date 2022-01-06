Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1834863E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiAFLru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiAFLrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:47:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 03:47:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z9so8324094edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fuYmQ09kebTGgQ/GK7r+JGLw9yYnF/KkITIwYbv8h8s=;
        b=hHhZ6fM67akVkyGgK/euqcLPjrBqR+nLz69Sl0IYo3asE0UPliJMugLM1EMHpH571t
         fmIkXRB6eHgfDrtUc0RWOXmr+BnR+C9JmOMah3vj6Sh7pKAC68LSaMDvfbb2GlpCk9Z8
         LD+VH7DkdhPqhtpdtJ2vbdpe3+3l/B15Nvy+3YU+5izusKFPe4kyPFLn3p3pLwlXss4d
         xhbcpt55SUmR1DWm8AFb98Q6A5Sl91/fAyUPOWPWD/Yl8ZiAsLCQ3Usod3uD9hdkxiet
         W+Uo3qKrNdbAl0oOIXakmCK+vEpYFIxo+M+SrWLPlOKHm5AUlULMQ921FXPf0lHsZS+2
         K3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fuYmQ09kebTGgQ/GK7r+JGLw9yYnF/KkITIwYbv8h8s=;
        b=jz5ga270ncC3cOepSamqKOJcH1+XWyFgzu4786IXuoBTGxjsgoCvforUY6uDcVjSv3
         hxRvxAKfFMQow8xVqu/q3Gd4UotUfWvRyLCJwzpWXbf5GByPMjTJZtawG9PJiTiKUKQR
         SL6/HkBAduqTQlIrONmKT1Ufsgip65FtROUeQKip+hN2LJSip6/fpHa3cW86dI9ReXh3
         k/LWQrShl21Tv4kkB1srC1NftMB4I/NwvwnQFU5W4N6nPhDceHbPeNJ/dqWeZNE/U5DB
         DfM9vO0y3u3QWefbyHGTkcHevsDMDZQUa8fDUIv56jACYjuKclt4lhEmVWXTKbf+feC5
         gsBA==
X-Gm-Message-State: AOAM533ZzZ1aDCRKChYUnViKuJh3YuoS0liXxcYi1hf/LZnAuORDpwEb
        TI2ia3dH4YFwssKeXekB7w/TdqmvaZqkXAkDRt0=
X-Google-Smtp-Source: ABdhPJzxdLfhXcKS39TbX5xCH2h/gifiQdZHtpksJgiLeA6YpQjcJrTYk64Tn1+Iqsn6iPJ09ubWNmYw9VRjb3rjgVc=
X-Received: by 2002:a50:da48:: with SMTP id a8mr56186341edk.155.1641469667571;
 Thu, 06 Jan 2022 03:47:47 -0800 (PST)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 08:47:36 -0300
Message-ID: <CAOMZO5A5H7HrCXoTAK98dkT0wEybcnuazPVxZeHvu78Nq7Qm4g@mail.gmail.com>
Subject: debugfs: Directory with parent 'regmap' already present!
To:     Mark Brown <broonie@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Matthias,

On an imx6q-sabresd board, I am still seeing:

debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap'
already present!

There was an earlier thread about this issue:
https://lkml.org/lkml/2021/7/26/95

but I am not sure what was the conclusion.

Any suggestions as to how to fix this warning?

Thanks,

Fabio Estevam
