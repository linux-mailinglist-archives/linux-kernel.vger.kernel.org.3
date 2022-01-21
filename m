Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBE495D33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379834AbiAUKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343845AbiAUKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:03:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888DC061574;
        Fri, 21 Jan 2022 02:03:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c2so16937487wml.1;
        Fri, 21 Jan 2022 02:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUxS/zeQsunxpJsOG0LYDIpNY7kfAUucM99foiqvVzk=;
        b=pX6TlZyD4a0hM/4aZBS0SQwg7NlgCRnD3s2HG/j32U8bZ6q+M4Ioo4E+1/FNalidRP
         PsCbFsGxtsrxQ3aFPwFgDOBV5KNtekm/7LPugJ33LOtAJYVeGMiW/uItmr0HJdKUOkBv
         A3ibgUZwHFcdMBDjNnJlMwea47FmvrmT5gG/KtF2HxaINld4e0xjz68zDIDuVFwiNh6A
         5aBQ78va1DJF0hDvvRTVaEHS6HDJWzTYbXajQ6nM9bNcTosB9HY18N853CLxAhHC7csz
         S3C1zev2OQkEQkB5zq89HWy0COuj1A5xBDb60365+PWEKC2yWT2n6ZT10d8J+xM5pfub
         sLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUxS/zeQsunxpJsOG0LYDIpNY7kfAUucM99foiqvVzk=;
        b=INP0RECrzJO+aRKoAQUzXwvDM+hNe3Hc6v8n7W0h7+zzRc5dU4/KK3HfZbrOzpbqjC
         VD+TlYSjRcM9+qnNlF234i7Qe8gfJLILj5KnvGz4ilbWsdIEl+R1OYICUl91bLMqjQo4
         0xZZclSv8luGiTHwiPqwvksFYZ+E+xkakCP0SUS0j/nsj0ENVJcwTopeTqdkEenkBM8U
         lNoCICp0QUD5E4Cnq9K0JUCbG4opyaDH29zoxr+fmAGoGHejgpJ1p0/1Fcea7iA7kjGr
         Iar2LT0VUpBCrrbFlgW2zrjaIOP5voNcqvgbHxR9mXvj++9WPLzLTewukbONPQFCS1SV
         82yQ==
X-Gm-Message-State: AOAM531imBAq/9OXz5U1rVdU6Y7C4ASHWGop03yHnmfA1/WVR6wy38wm
        cybvHepNT2bS65C4LJdXnrA=
X-Google-Smtp-Source: ABdhPJw39nwCec1xtUFC9eSn7jMDLduA8S5SSIMCmeGctD69Vg18ouqMxMhFecNt0QrchUuwt5qopQ==
X-Received: by 2002:adf:e291:: with SMTP id v17mr3167264wri.479.1642759401615;
        Fri, 21 Jan 2022 02:03:21 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id n16sm4484235wms.13.2022.01.21.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:03:21 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mosescb.dev@gmail.com
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH] drivers: staging: media: omap4iss: Use BIT macro instead of left shifting
Date:   Fri, 21 Jan 2022 11:02:58 +0100
Message-Id: <20220121100258.336877-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121093722.320082-1-mosescb.dev@gmail.com>
References: <20220121093722.320082-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
Use BIT(0) as suggested by Dan

Best,
Moses


