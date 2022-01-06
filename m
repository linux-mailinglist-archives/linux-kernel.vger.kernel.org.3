Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FF486204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiAFJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiAFJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:21:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCBEC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:21:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 196so2007562pfw.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fzgt9zxSHcPkh1WkdxXMfweNiiTBX5PEz7HmeOWT72Q=;
        b=xoAuLNJ9bvyJ8CGNT5J54S/w/ze31xAIvby4o95vD1lBjujxunZXp9gJ8X0ahDAOWq
         KsWBKyH/BAy4hQEtaFfExdVBYZULlGbVJ900Jdj5CtNg5fRUjN11j26fYqXGwUjoaTkQ
         oiMmYaqWIihvOf8KuoSLx4ror9iZzooiFYeNtxlroaRErX4SQmS/Lb6anQ86b9SqJSND
         wZYJtGe1uRnVdUBoMFlJgmpQ7YIzwMNUWYKs3qzdTUATQXiohO0+7G7032MqgZ5eWTHy
         T2Mpz7SM8dCRqFVR6iPswoeRi40ODQ99DZF7JRILgI9tPirNDjbt9FkYotJSZo6X30Fl
         oTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fzgt9zxSHcPkh1WkdxXMfweNiiTBX5PEz7HmeOWT72Q=;
        b=tevzgM9arP2Hz2a5/d0xSBVr3VL6YRxixbgKIvI8A0kdx+7rlw+gDyqAg8B0c0orNg
         bNg4YR/vxO0w8jmnalgfGA2cfFMdLCCfmb8oE8RytJeYDS9r6E89HtvcnxFESGLNlP0d
         VmeIwo+yd3UVNRv1Q1NvbyEzInv3Y42U4Gl+uwsfXwHXMrayzEs/PL95L5gwkyD7VH8h
         nnWCEudLq+mX2Q8W38oZTXgtnqmLO14cfPxaQycNKFO4l8wpCwEGzUsr8bE1bNSEE2aS
         mwlXe0R+AtduDTYUHHTvav4lk9x1mEvIhTCSocEIQuRYMDIejkoIw95F5TrC2Nk3uBpS
         6qug==
X-Gm-Message-State: AOAM531YED8Oa5bOnDz6UevVLbJ3VWZQJJ+nbSoFpsDTEQl3HQwB0TLM
        Pm2veqQV0f33f2kENDOsFLX/yA==
X-Google-Smtp-Source: ABdhPJyjUy+PMpsgqKthOHIuAudhDSM/tYbR3spYsGrZeQtiJXV91F8xbkATdwPhlfz2kHYI+UFL1w==
X-Received: by 2002:a05:6a00:a84:b0:4ba:557e:12cb with SMTP id b4-20020a056a000a8400b004ba557e12cbmr58762298pfl.85.1641460867294;
        Thu, 06 Jan 2022 01:21:07 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id v70sm1423214pgd.91.2022.01.06.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:21:06 -0800 (PST)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     phoenixshen@google.com
Subject: Re: [PATCH] HID: google: modify HID device groups of eel
Date:   Thu,  6 Jan 2022 17:21:03 +0800
Message-Id: <20220106092103.2283-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211228114650.31981-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20211228114650.31981-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  EEL keyboard belongs to VIVALDI device. I have tested it.

please help to review this.

thanks.
