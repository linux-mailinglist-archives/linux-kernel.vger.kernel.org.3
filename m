Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECC477CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbhLPTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:54:41 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:34552 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLPTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:54:40 -0500
Received: by mail-oo1-f46.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so65528oog.1;
        Thu, 16 Dec 2021 11:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jbr0kQDcWWqb0s9hRxGK7PGiKfX7yDCReK4EV7U8OPk=;
        b=QwWnl8nIxd8hOOS1nGekuRip2uKmWlwCGG4G0Wo7vsVAQU7a4eBmLNY1W5I4wJwHQ2
         0rHCD2bk04saqGEhuB4cLI5YETQh7OJKgfZ3pO98YO9BNharYuabSbFbtPoh91B3Z3KG
         9j9TpA2tCt/g+BsqEyu4PP5pInCQxu4m+jQBlTh1Rqf6kiSe0PIg8/Lu1hYxc3DPgYi1
         1ljhWz1hUwS0j67E5Scdilq/EelR/Sx0EzUdxkzOL7ffm07RrXI+rQi3Kg4JYAYnR7tY
         fH3kZiw3tWnssQFmNXrFyXzMij4VoTuRHtMXdti9CVlOffwzfqTyh8/pmPSo1blkdHBy
         ws6Q==
X-Gm-Message-State: AOAM533NbZXZrt5ecC++nAjb8N0uEciBtw8Aw4pA6bsjBueLQkYXPThn
        vkT0noBU9U4B3FcAFa0SsMYdt21ALw==
X-Google-Smtp-Source: ABdhPJykmOfk0C0z5oJWBBPYmvhECYtVi/l3Pad7mQj0cu4DcryBDrrtUbEC85ZS8wepZsTeKCGcgQ==
X-Received: by 2002:a4a:d9c8:: with SMTP id l8mr12200296oou.81.1639684479815;
        Thu, 16 Dec 2021 11:54:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w17sm1196106oth.17.2021.12.16.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 11:54:39 -0800 (PST)
Received: (nullmailer pid 645126 invoked by uid 1000);
        Thu, 16 Dec 2021 19:54:38 -0000
Date:   Thu, 16 Dec 2021 13:54:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND 2/7] dt-bindings: clock: hi3670-clock.txt: add
 pmctrl compatible
Message-ID: <YbuZfubriVXNU5Qr@robh.at.kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
 <3bbfdbd02eea5af71cb37b525be330c864395285.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbfdbd02eea5af71cb37b525be330c864395285.1639558366.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 09:54:28 +0100, Mauro Carvalho Chehab wrote:
> Add a compatible for the Power Management domain controller,
> which is needed in order to control power for the PCI devices
> on HiKey 970.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/
> 
>  Documentation/devicetree/bindings/clock/hi3670-clock.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
