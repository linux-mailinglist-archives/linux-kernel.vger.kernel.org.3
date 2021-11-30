Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0047B464366
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhK3Xf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbhK3XfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:35:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CACC061757;
        Tue, 30 Nov 2021 15:31:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l25so93459192eda.11;
        Tue, 30 Nov 2021 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=GC+UmE4xf31M5GKs7v6iZVMt61mrocgYm77VZ+XNZgQ=;
        b=AUCtJhy+HGMs29u2oHpCScMfEFbA5pIVkkR7icLIhPdy6TmBoTAk2EfbEeH9ic/C18
         m0tfTOccsp/PtgUmW8hKSKylf+XA+Sc1FYGz9oRg3azyg8KEo/Ppn/XUOp5YGIkNTG20
         VQozDLpuIcVuk/dNc79MJOnZ7y/T+c8DLzfGy/EdowbKikbWggJ7VxsNDCxj33Hz4al9
         JGsX5GQPxMUkXHEJKYJt4RawP66kbEAlw2n+QcdiivXYXtYKRQuCF7UWh+rYLDzYTw2q
         ZBRFWdoRqrFO3AWcNsIwBRKLKDcgLtj5XVNwmi2FE17mK9D15lS0X1B+fbAvcanUTUoh
         25yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=GC+UmE4xf31M5GKs7v6iZVMt61mrocgYm77VZ+XNZgQ=;
        b=6maMjCD+LvYFg64NEevC2MrWV9lzGjYCD28UsUaoBpU2yP3U7VLXKqhjElWo49Rd9i
         RdzU4vSjs3Cxn5nLwEjJKdH/ouVU4OOBHxHukBUgM99gTZVkGhrDVZ1+1rvGxscObA8w
         XEF+VpbiuRC9684g7tCnJHy+SNPX6WRx3DDXdXi5bmmgMq41bHGbWe7lliHSR7k2HfXU
         MwCzrhd9NmtVyBA1qEt6mK/ZgQDlzbfjd+/LvToI1j0W0KwZ36ebole/F4uXcjkz3Nd9
         Mrw7OQiMpyyqO7t34aR9ojNRU2jdtykNI0gK0XXWBEi4KEHeArc6uc3M3G9dRO3pZG7w
         h6mw==
X-Gm-Message-State: AOAM530S4uiCk3cgbVo30Ow9J6bAfvckp1GsYSq60b5J2GSc8VwLCDLZ
        e0J+hmmmpBLQzTGHvp6SQEfEERhI4v8YsQ==
X-Google-Smtp-Source: ABdhPJzequx1qmn13ItHUCSedbVBl793btQDeZH9R2o+7PSr3cSd0e0ZdpjfncLsUuuZk4wOHa2Rgw==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr3078811edr.227.1638315098509;
        Tue, 30 Nov 2021 15:31:38 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id z8sm13492232edb.5.2021.11.30.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:31:38 -0800 (PST)
Date:   Wed, 1 Dec 2021 00:31:36 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] arm64: dts: Place LG Bullhead generic code into a
 DTSI file
Message-ID: <Yaa0WKxSg/rX8O5A@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211130225645.171725-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130225645.171725-1-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

Also, very minor nit:

subject could contain also "msm8992-lg-bullhead:", i.e.:
arm64: dts: msm8992-lg-bullhead:

Kind regards,
Petr
