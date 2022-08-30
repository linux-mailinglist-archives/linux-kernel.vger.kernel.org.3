Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3A5A6B76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiH3R6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiH3R53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:57:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3A75FAC1;
        Tue, 30 Aug 2022 10:55:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f12so11681440plb.11;
        Tue, 30 Aug 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=vb9Txx5Uh/L+QuxtJIth7TcErE5X34YjzO6bgHHP7Tg=;
        b=IQ6xAu3/nXAWwamZXWcaFQ5otw2ovfEAK4lLyx+PRD57VdFwOM2jBY1BuCMVAwn7lU
         EMmos/MovZ5fMPZyk+r1pR/0arZL/v91ZhSEme+8nZJH3/9xvEcJ9VVIV/Z6rCg9lojY
         1pY2xe5wDnLcpkNKAS2KtrERRAbQ+b2Gqmi9eWgpuhG3y6QvZx/hrAehjDO+iBbK+IdN
         VdQBIH1EzxOyWEDAH8u1gsdL/5orqIEt3Z+bSBctIyBmk9zSoD1rnPYmb5BYrXvriKMQ
         apEaeUhBjtGKUjm6mQHqliR5T4WHYJTazmT6OPT7LpZVbtCX7h7fnMHj6TZxyyHVBbve
         5qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=vb9Txx5Uh/L+QuxtJIth7TcErE5X34YjzO6bgHHP7Tg=;
        b=o+KW40llG7XZfBxk8qoH24akYRReGECP4UuERfYkG3gXeOJe7ElMY113tgd0tgtz5r
         hhe1FNirholxOF52jJ5mZerbhX9nyazYp0mo7glAQqofUeXRp2/R0sFwuPsOPPK230ic
         wFQrXx5Wbz9Fzmfzp/oDlk23Namuz5qjTL2m6E5CVNcOdGymHvlPpPVkT884sJIz9ESD
         obAu8i1J5wcF7+GtjkQFwdSWYpmVlg2NfWNlKj00TasdnZzf0gX5zI+/fIjNItPxtoZ5
         coKE7eFm023sy2rFz1OoNYZNhfRMUe115G9fGRbizAdZyuS0XjyIcKNDPJppIH6dNlnB
         LU1Q==
X-Gm-Message-State: ACgBeo0MgTQzN5ajFcXtztLfi9CvWnLuH9yrlzDAB+s2ULm/y2UKrFtr
        4syP2Ckjot+s4s1L1FKjd1Q=
X-Google-Smtp-Source: AA6agR5cWVfYgwip1zhIhpvSKqyEy5SVodf9cOoo6ad7WG1uiD/shmfC+3NK2w/cufXKcxObqaek3g==
X-Received: by 2002:a17:902:a60c:b0:171:407d:16f8 with SMTP id u12-20020a170902a60c00b00171407d16f8mr21914557plq.58.1661882127096;
        Tue, 30 Aug 2022 10:55:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 124-20020a620482000000b0052deda6e3d2sm9874679pfe.98.2022.08.30.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:55:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 10:55:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 4/4] usb: typec: maxim_contaminant: Implement
 check_contaminant callback
Message-ID: <20220830175523.GA239841@roeck-us.net>
References: <20220826084001.3341215-1-badhri@google.com>
 <20220826084001.3341215-4-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826084001.3341215-4-badhri@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:40:01AM -0700, Badhri Jagan Sridharan wrote:
> Maxim TCPC has additional ADCs and low current(1ua) current source
> to measure the impedance of CC and SBU pins. When tcpm invokes
> the check_contaminant callback, Maxim TCPC measures the impedance
> of the CC & SBU pins and when the impedance measured is less than
> 1MOhm, it is assumed that USB-C port is contaminated. CC comparators
> are also checked to differentiate between presence of sink and
> contaminant. Once USB-C is deemed to be contaminated, MAXIM TCPC
> has additional hardware to disable normal DRP toggling cycle and
> enable 1ua on CC pins once every 2.4secs/4.8secs. Maxim TCPC
> interrupts AP once the impedance on the CC pin is above the
> 1MOhm threshold. The Maxim tcpc driver then signals TCPM_PORT_CLEAN
> to restart toggling.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/Makefile            |   2 +-
>  drivers/usb/typec/tcpm/maxim_contaminant.c | 338 +++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpci_maxim.c       |  34 ++-
>  drivers/usb/typec/tcpm/tcpci_maxim.h       |  68 +++++
>  4 files changed, 429 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/usb/typec/tcpm/maxim_contaminant.c
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.h
> 
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index 906d9dced8e7..81e4e9421fa0 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
>  obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
>  obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
>  obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
> -obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
> +obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o maxim_contaminant.o

This creates two separate modules, which doesn't really add any value.
I would suggest to adjust the file names and create a single module
named tcpci_maxim instead. Renaming tcpci_maxim.c to, say,
tcpci_maxim_core.c and

obj-$(CONFIG_TYPEC_TCPCI_MAXIM) += tcpci_maxim.o
tcpci_maxim-y := tcpci_maxim_core.o maxim_contaminant.o

should do. This would also avoid the need for exporting symbols
from tcpci_maxim.c.

Thanks,
Guenter
