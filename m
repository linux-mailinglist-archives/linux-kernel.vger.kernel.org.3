Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677347093C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhLJStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:49:15 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36400 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhLJStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:49:14 -0500
Received: by mail-oi1-f175.google.com with SMTP id t23so14454618oiw.3;
        Fri, 10 Dec 2021 10:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RER/iWppV8hMmnZQD4dlpK+kku9THlBKxNx02Kauc1U=;
        b=FgGKcxJ++K+AkvtDzpgMswQnLOliQJ8wzHOk5BrTgtczl9yNqFAHtQl1b2f6oyHjcP
         whV6IvpKQQ0hSkJLYkqzroiaz8x6QubiNH+ujkzw8cqkrFGBJh7hi9t4N0RUCoWFovN0
         +hMbsczMJVu8xCVHMD7cnLyIYCnm4U7njvLtvUz8OC1nHrYo1nU4e4q4MNzYutMF8ye8
         uYxFCPYqybltjH/dYEdQJSrjNE+B+YsiTedQyMShpgS3Hs8Pn54QUYUMqeJeL4dScuOS
         jELrS6PUnXxR+lcx00Q5YcgMu56mrlHGFtKazBlUUO7vVqnwbNVymsJdUlXR9cRe4I9t
         n8zQ==
X-Gm-Message-State: AOAM5337teQ3aJx2SNfTYiIMswmBmr9sOI/CbJB+pwXvONTDqpnrD4sM
        WQUuQ/gOpmZnf+gpJrYbVA==
X-Google-Smtp-Source: ABdhPJwT16W0aC4a3LaA1eXQEG2Ta3HqdgEh97oXtM7v5sDKulhdS+IbM7yFjdRFsiyNfNlmmQOhzA==
X-Received: by 2002:aca:1a04:: with SMTP id a4mr13550300oia.153.1639161938754;
        Fri, 10 Dec 2021 10:45:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm963557oiw.23.2021.12.10.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:45:37 -0800 (PST)
Received: (nullmailer pid 1684290 invoked by uid 1000);
        Fri, 10 Dec 2021 18:45:36 -0000
Date:   Fri, 10 Dec 2021 12:45:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        srinivas.kandagatla@linaro.org, perex@perex.cz,
        lgirdwood@gmail.com, rohitkr@codeaurora.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org, agross@kernel.org,
        tiwai@suse.com
Subject: Re: [RESEND, v9 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu
 bindings
Message-ID: <YbOgUPpQjBhqGhHC@robh.at.kernel.org>
References: <1638800567-27222-1-git-send-email-quic_srivasam@quicinc.com>
 <1638800567-27222-10-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638800567-27222-10-git-send-email-quic_srivasam@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 19:52:46 +0530, Srinivasa Rao Mandadapu wrote:
> Add bindings for sc7280 lpass cpu driver which supports
> audio over i2s based speaker, soundwire based headset, msm dmics
> and HDMI Port.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 75 +++++++++++++++++++---
>  1 file changed, 67 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
