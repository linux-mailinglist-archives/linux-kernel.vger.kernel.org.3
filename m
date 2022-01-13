Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAF48DF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiAMUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiAMUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:38:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98015C061574;
        Thu, 13 Jan 2022 12:38:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so12221416wrb.13;
        Thu, 13 Jan 2022 12:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRZAInERcxw5DZyW/jSKGEHi9YIRyvi5yEcYVbt0yTg=;
        b=lky5UTc9aWGA17vjXdsC4Z+ZB6BbMM9DIqVRAEUPPaLb0gOfbWmqoTn6HV4iNC6jvK
         s5AuITBIByjDSx1V+nG/p7qlwCqD7ZuHkIiH1tYiFuNanv4LgsuF9kfURIVgPtERhaTr
         WEdbdZ6Kx/bMv8nopDVjuppwui5HTuhHApPiVIf+h6EBmq6hwx2SNT7EMpqfoNwVy4ZI
         vJxaGwe+yf2ibzeOj/PjP9H9ZOeEDIpGcuFOVAmXuJ6IDiZaYPhXLTEW0S5LQxSoxHcM
         CMTBVGRVFs1wAPzGdl6G6jJtSWva2y9W4jO05XltsQzD214jrf1PFRX60D8qJEv9W2ke
         9Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=uRZAInERcxw5DZyW/jSKGEHi9YIRyvi5yEcYVbt0yTg=;
        b=6CHQ9c+aHMVYdwLxRiBHqbeTI46M1gCGBw+9wazoBe+rQNPZliE11ZwEasWSjT6bZN
         a3HKuZpZoFL5Nb9eXt1VXioaKpGdvfn0lKWdT4JHk/g4WOG+TgHf8N+TfnkCBTJ4Lhdy
         R9rcKfCq6YLL2jsjChf7F44SE4TEgfuaNzeJVNw36Bf0auO6lxs6g8JAOQvXwntGGJ0S
         OTaW/+HSbVGAE7hhSv+pXcYGPPIBJrZg9NquTnwWgQpeNtN7CjdJi1tTfvmn6C+yMV/k
         WbAn2K6EFr1iWbDZEsga1EtfRIfB5Ekc+En06cvaYJ8FyJ0Rav8AfzviDwc9YEDCnE25
         cyKQ==
X-Gm-Message-State: AOAM532zZtNnn7R2eBLTAF8EE3Xf9ZCRNqZ1fRVGV1zJvOCIbpfAM14f
        NIVRjk7BXRx/MQcQTAUefJLNwIHgVpTFeQ==
X-Google-Smtp-Source: ABdhPJx1vj7MK86qymJ/LBhgLCXaQfrFqeBoq90p8eiyFy7N35SUaZfmbTgWVyL8lgSLup7sKlafkA==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr5465424wrs.322.1642106336223;
        Thu, 13 Jan 2022 12:38:56 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id n9sm8993695wmq.37.2022.01.13.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:38:55 -0800 (PST)
Date:   Thu, 13 Jan 2022 21:38:53 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, konradybcio@gmail.com
Subject: Re: [PATCH v2 1/2] arm64: dts: msm8992-lg-bullhead: Place LG
 Bullhead generic code into a DTSI file
Message-ID: <YeCN3S/iEh6z4vOj@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211201231832.188634-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201231832.188634-1-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

also for next time, also "qcom:" should be in subject (very minor).

Kind regards,
Petr
