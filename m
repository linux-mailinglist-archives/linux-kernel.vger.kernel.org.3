Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3D4930F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiARWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiARWkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:40:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C536EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:40:21 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r138so1222823oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=8Y38umng4C9WuYauadkz1zPq/MPwH979LI7tT4AT+7A=;
        b=Fbq0j8+35mXTdP52ZD1yargmnSo0Ar0fNmnCIYNNbgDy4e9WQQxMLhgQcoNb/JDHpB
         pbYyA+jsHkgj9J0q8Fo1+tqjL+LkasBuhbIt7z+Q7HQN/YkuNpoByZfyzYHjyYXZlF+2
         35VbC9NLVW7bdS6C1tRRPdpNQW1WQ1vTVzA98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=8Y38umng4C9WuYauadkz1zPq/MPwH979LI7tT4AT+7A=;
        b=iTs/h+j2GMOb5zjEgikmQC+L5aRbllvqPaZdwZkHg9zsRdYPyBTS4BteG0oJ3bt8kO
         4b9E/prGhRmgTE6HHz2zGUKU/Q4rNJ+gWLhDWHxqJj0tVfAuHT7s7m9dQAr+Bo2O6DDE
         hAJw0+/9sBMFmmb4YmJB2sF/KYvxSImwfgSxw1RtRU04xdiV7CqgDC3fPN/e12Q1amlK
         DOI1ptmZLbjVTXKMEgtQHcPKpI52QZ3J989ekpj38xkDGiLoJkf0I5awviy+OJBE0+sI
         ud2cQuwd0/UPtbEtXDp3Q8KcKzpHo9q0xV46LJ8Rbei/X18x5sDUe6nidtfgjLzWvYBk
         vqSw==
X-Gm-Message-State: AOAM5313JWb6ph9WLRLvc39CqtJ+PP4gEYx1cD/kJg7pWosvJpY/Jt9O
        JATZWKjiuSbtoLbH3yi2yEeDi2u3VfTpKB+paW/Tjw==
X-Google-Smtp-Source: ABdhPJzT5GCTNKLOYVTYq8m0PkvSAaijgf2xXhPdgcCvmSRXndcQOrPsGJIpAExr5xx9IoMIkporcc79xodBdS8p7RY=
X-Received: by 2002:a05:6808:cc:: with SMTP id t12mr623686oic.32.1642545621239;
 Tue, 18 Jan 2022 14:40:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jan 2022 14:40:20 -0800
MIME-Version: 1.0
In-Reply-To: <20220116125702.389471-1-trix@redhat.com>
References: <20220116125702.389471-1-trix@redhat.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 18 Jan 2022 14:40:20 -0800
Message-ID: <CAE-0n51j_aoNZDWRcux64cR0jAPe2wVS-4nSHLVXFVm0g1GwDQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: cleanup double word in comment
To:     Jonathan.Cameron@huawei.com, bleung@chromium.org,
        dnojiri@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org, trix@redhat.com,
        yuhsuan@chromium.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2022-01-16 04:57:02)
> From: Tom Rix <trix@redhat.com>
>
> Remove the second 'using'.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
