Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CAB49E028
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiA0LDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiA0LDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:03:10 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF87C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:03:10 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so7530799ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1OHZCx3Rhx2oiGyELxxvlE7v4t4IvtjC6wE5ftozco=;
        b=TSYkxeyF9q7I03XCBICWFXpdXw98xt7G5iC4E8JimlL8xwnsE2hnsnwVPQ8X2tcP4y
         T0pMQkPYyyvIW5Zrg5wN56sdZf/t+1nzjPH8vVnO0WgWztw6wh+N8uZe+67Zti0J4cOx
         XzWt1hKp7zNUPDoKWdk0BxzuD6FBTFDXYcj1I0mDMeMbps64N8lWMkBYCRCp55YPCuGJ
         8e4fXjDBKGanSV85jjApKzy8X/wbTAwDVxlS5fPfLFt2AwipSZxeoyzbyM0Q1ZkmKkOd
         02IszmDHGXoXNz0bqhvb0OBKWiDXG7WCudGxAouuuUPP14a1niJxv9RxqleV1mu+BATm
         qdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1OHZCx3Rhx2oiGyELxxvlE7v4t4IvtjC6wE5ftozco=;
        b=W9NPNuMHsLsZGSqH0ae4uXNBojvG3NKu2oPSUU7DICEZjuiesYWHZ4vI+6cvyl+qv9
         WkxGhgSJsn8JPa5O0fiKwBXWCDdW/l8YMs54ROkblYkR6wKm/qg9uSqw2tFABNsUORt0
         LPeuMBVX3L7HZrRI/iFYcwg/pPdZFh0TdOii2cwPPi8ardhrrdoaS64C47Cdwb3EGjpo
         jA11y7ZNQ9EG01D9IP3WzXeI7R+uCaYug4f8s4oBDlzgJ2ONliYBiaSOlIiVHBbRMWPB
         xrUTynjZYBJfVuNhN27zhtMJFsJ48NN1eAdrf5tAOLZW8gCrGuAEte6WO1uFbSgNqhAo
         lEEQ==
X-Gm-Message-State: AOAM531TAgyjaoZnAyRfmOMRKf7xZ6W81i/qfGJJyXAOu/lSaibdhDmu
        MTK2PaQ+k7qyBYuhkPDw2SL5xyEEFsYlfN9tWyYW6g==
X-Google-Smtp-Source: ABdhPJxdz/jhiQ15H91Ot35YzA1DFSyUQO2xE3gRwUltWkvVDDelPxaNCFlALIo3QG0WslXSvdKjBaW2aTHIdyzNFaQ=
X-Received: by 2002:a5b:47:: with SMTP id e7mr4778699ybp.553.1643281389318;
 Thu, 27 Jan 2022 03:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20220125155447.179130255@linuxfoundation.org> <ddd3f2e1-ed1d-82ce-cc8e-562be2ae5152@linaro.org>
 <YfI4oDEY7W4lxWZP@kroah.com>
In-Reply-To: <YfI4oDEY7W4lxWZP@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 27 Jan 2022 16:32:58 +0530
Message-ID: <CA+G9fYsPFjmgmAQmLT84Nmx34J-ROQDjkN0qTdYhUi-BkcnDiA@mail.gmail.com>
Subject: Re: [PATCH 5.16 0000/1033] 5.16.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        lkft-triage@lists.linaro.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> No Tested-by: line?

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org
