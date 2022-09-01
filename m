Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4175A9488
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiIAKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiIAKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:25:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31864220F9;
        Thu,  1 Sep 2022 03:25:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s22so10340923qkj.3;
        Thu, 01 Sep 2022 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K1bm7RyualIZm4tI11MDvsJjpqUlKFhuZrCU2vFAKkk=;
        b=R3NXH2z7BmO8Qy6LRoJTRWNd8ulKppFQgGgiTrZ770S0MuMBV1Yef0Dpx/KQYBEYGO
         UCtyeN5BluAgjvE98z2xPe4utvK6CYNuswjnMcQPdCsIyVfYZg6e8ULRpTUmNb8KDEyn
         M1eyBpzdU6hZQPj2CIrjHWqjn8Wnv4zWDldUsmaLkUQndMcf8WIQV5fIVQ07LVSeJcq7
         KFBPrF1S3g6qrsrpD+zSpCrGnfAMkf/psKopIZQduLEcsmWRIb6z4T98+pwsPrQ6HKQ4
         Wt2v/yLVqsV9z+gPKBg3jnE2ndbK6YjS8MkFIAx3VuRp6VoRKZ0LlWb2gp4eSQzgJGoq
         tA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K1bm7RyualIZm4tI11MDvsJjpqUlKFhuZrCU2vFAKkk=;
        b=tCGR424Zsl1i1aUK9++laxVO6d80YEl0Hg89oOh7zvPHgzDUO2wOWB1fjswVEPDxdi
         vI1DSwcL9CBY9E38oBrF1XjZ/yCiRks3nyLjQAc3XZKfXOVyQxXcsAq9HbJ6VBBXJHmh
         dQxYA6O1a+R5JDLnagJCptPokpIyrVE/eCsuZsSmXY4jfnLcEyeJR3aupImJBXhrSSKT
         p+aJGAb9PofpsxLA0FWo0W71CJLrmH1HQWRdK2l3wVfsDvjJ1H9RdtIdiJT/zvuRW4oM
         6nAhy+d2IQFWwhiEZHU8pXgnsJW5NUhMhtGMaWIPsoTY3GaDMU9H1i0UPKsgnZM6Gvsr
         q6CA==
X-Gm-Message-State: ACgBeo2OKNp0dFAUqoxm7ESShLNONfbNMHy+4MYwhctrG4mbDPpuFS1o
        RKFYlYfNGshN9IDmcmntFj+o3VVzqFnDZ5zQWMDATlR+XHQ=
X-Google-Smtp-Source: AA6agR5unLxYHtG4VyVYWHtbs0DX+0SODfzErAeOl6yE+Hjvdh8eIR8xDUGb1ZKxvtGnM5Cw86zUOPS8LoKZZn68DGc=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr18887210qkf.320.1662027917242; Thu, 01
 Sep 2022 03:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <1662026651-172787-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1662026651-172787-1-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 13:24:41 +0300
Message-ID: <CAHp75VdObOKv0aamL3+d8A7f3Asxj0SnOXtV5TYAUDAC_s3Mpg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform: Use PLATFORM_DEVID_NONE in acpi_create_platform_device()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 1:10 PM John Garry <john.garry@huawei.com> wrote:
>
> Instead of hardcoding the value for the id, use PLATFORM_DEVID_NONE.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index de3cbf152dee..d33334c9b8e5 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -140,7 +140,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>         pdevinfo.parent = adev->parent ?
>                 acpi_get_first_physical_node(adev->parent) : NULL;
>         pdevinfo.name = dev_name(&adev->dev);
> -       pdevinfo.id = -1;
> +       pdevinfo.id = PLATFORM_DEVID_NONE;
>         pdevinfo.res = resources;
>         pdevinfo.num_res = count;
>         pdevinfo.fwnode = acpi_fwnode_handle(adev);
> --
> 2.35.3
>


-- 
With Best Regards,
Andy Shevchenko
