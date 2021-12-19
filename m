Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2923947A1F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 20:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhLSTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhLSTgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 14:36:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 11:36:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 196so3312043pfw.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cl6NxV+zATZ2semIbLlLmt5qBY8ZUZt/u+uJChmMDWw=;
        b=Vt9GlxwdmkDhSp3duTLMNAGhxRWQqHFNDTmAXh4iiEs/+Df7bbFCNH7FNdRoLXHOXZ
         vfJ2mZ7OpwLvdrUMP9EY50USDnY23hOsaJ66Wn9uYjTSb5DZNw4c3+bUPP5aWxncUo0u
         tLDpzJAJZoNZzHnWbducJDTeFGrSGhH5R+bopvDuBRI8OhOWX5SpYMWSV9aGFsRAE9WY
         RsCnnawQTkZUpCItjz6IL27r+qKiP3pPfzJi73cUvYe12G+XYfpelFRdCahfds4X3a2j
         1iyg5eNUGt9LNaM/uyMoUBd+RbsqnC8UUdsJMErj3ARZVF9M1+8Q2p0YWQV7PFo5ipXm
         DZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cl6NxV+zATZ2semIbLlLmt5qBY8ZUZt/u+uJChmMDWw=;
        b=sMfFiQbfhv3hgflghFNDK/XP+HHRrGF28oWqYUuKBbhcVxhcaSS+/2PlmYLHHraSzQ
         /xeWopYkD6BXpYj7pyydXzZWP1p6rXSpR5I/+YGw8w3HtpXGOsYcJNvte3gy79CBRe4I
         hmAoTHFOwKl+83elTFhLifcwLsNuloK5fmK91Siz8Bq3tz3AotBBxu91IvBS6QOGRKJr
         H46dmnjWbwufIs2rX/ngwdlNQVxtBcAGJfbb2Z5FcLoP0FQpjhkSGZO8/qp7ASEKrFgP
         rOyiJQwEGJ39v62PwtKtV90bgAqxs23hMHXv7QJ+xIbVS+0kCrjHb91wp/XOlfpiyvtg
         RzUg==
X-Gm-Message-State: AOAM532esgYir1cLUBmIdYmjJpUr9Qd+K4FdKJE1bcMewl+MrNQt75Di
        eXR2gSy7TiUSnOFE19N59TI=
X-Google-Smtp-Source: ABdhPJzd21NbXmqUfW2XHrWROm2fxyILq6CZdCCvdtiStf4Y2M/KHTSAJ01oFeaMXd485QpNHVfiLg==
X-Received: by 2002:a05:6a00:15c7:b0:49f:f48b:f96e with SMTP id o7-20020a056a0015c700b0049ff48bf96emr12907087pfu.65.1639942607031;
        Sun, 19 Dec 2021 11:36:47 -0800 (PST)
Received: from [10.1.10.177] (c-71-198-249-153.hsd1.ca.comcast.net. [71.198.249.153])
        by smtp.gmail.com with ESMTPSA id z3sm16762961pfe.174.2021.12.19.11.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 11:36:46 -0800 (PST)
Message-ID: <05f4ddfe-7f6d-86a7-b568-57bbcf2e4d22@gmail.com>
Date:   Sun, 19 Dec 2021 11:36:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL v2 1/1] bcm2835-bindings-2021-12-18
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20211218181135.192699-1-nsaenz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211218181135.192699-1-nsaenz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2021 10:11 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-bindings-2021-12-18
> 
> for you to fetch changes up to eafba51c545a165b29777cde1fc8b04781a0a8db:
> 
>    dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema (2021-12-18 18:54:57 +0100)
> 
> ----------------------------------------------------------------
> Stefan Wahren converts VCHIQ's bindings to YAML format.
> 
> ----------------------------------------------------------------

Applied to devicetree/next, thanks for the quick turnaround Nicolas!
-- 
Florian
