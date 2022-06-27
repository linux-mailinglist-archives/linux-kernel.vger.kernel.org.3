Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4255E177
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiF0OsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiF0OsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:48:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FF5F96;
        Mon, 27 Jun 2022 07:48:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i1so8922528wrb.11;
        Mon, 27 Jun 2022 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vajkrPHc2kdtVXzMwbmKv0mu0zOE15b3yojVxzRhH8U=;
        b=lq1SiFCUPTiw38F9BCLPRy6lLtcDUSB7H/DSBaSB5Gfh6Q4o7dDiHbAXI/pB3F5/7t
         qG/LitLAT46c9sRfwXEE/viZ+mvnFVL0OQY7fwU+cTHNSPGjnuQuXD9b2ud/zVsJb/cf
         c1DUXLwOimuxVMDPoeKd6KJ04iFCVTjztIlx9leJdWhVVFVN2gvwTbP209tX+6+Wpy+f
         OjWX+0q2wNbuplyXfyE0S7eNv8PnqIK8ooapU82rAk9VfrkZ6ChEFMSofP1lBXZgNIEp
         LomRbAwrvx8wwsHi+i0YOVa7rQAthqJusKL4gTr9/WYX+l/qBWtJmWBfpDap9l58Buy7
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vajkrPHc2kdtVXzMwbmKv0mu0zOE15b3yojVxzRhH8U=;
        b=N3y2KiqmylVU2+QuFRRwnt9w3iw+PCuOOc5ey8ArjBkPHYyM0ZdV3ROjNnFqANI4RA
         VnHLIHOs6atvXmy7WF7O2qbqYMNqhIzKoh4iw5B7b0DFQDfDwmDFpFqiSx6qYvT6gXFz
         6lwESfd8R3ZnTdCFle91tWuduRoM3mof9eMLgr03aO0e9NrfE2lQb0u4sfaQZejQtFM+
         m+7qKUuBNu7hdq5x5tgmqgChTek3nHZZ7BbDk2218snLZiWgmRoTkYGa5ra3tsT/ttaP
         czVn/UHvGoY/ZklciTt+d9vTshhwK6MGshn16lITVlTWr7LjwYTxDU2WU5Y7mngu7H87
         9E5A==
X-Gm-Message-State: AJIora9tz2r5C1XOtIviMmPzuSCqg1Vm/3Hr+rLzBOZd71GI9WZRwYwd
        BEwVB7IGL+kkXufmuDf3P/kfSZ6No9VXzqSP3xk=
X-Google-Smtp-Source: AGRyM1u6ojF9n9v9xGvAI9r9+rRnnj9vayuFlSL2GHs8AByrH3GMZSKH8CnEtt9j74Q9oEIem3zNBA==
X-Received: by 2002:a5d:6d8b:0:b0:21b:9814:793d with SMTP id l11-20020a5d6d8b000000b0021b9814793dmr12621626wrs.344.1656341294084;
        Mon, 27 Jun 2022 07:48:14 -0700 (PDT)
Received: from [192.168.1.108] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id az14-20020a05600c600e00b003a04c74efd1sm2080441wmb.21.2022.06.27.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:48:13 -0700 (PDT)
Message-ID: <a57e1d14dda4f902cedddcfcea9a16a8e58316e6.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jun 2022 16:48:01 +0200
In-Reply-To: <202206260803.ctZKSyI9-lkp@intel.com>
References: <202206260803.ctZKSyI9-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-06-27 at 10:37 +0300, Dan Carpenter wrote:
> Hi Angel,
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
> base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/iio/pressure/bmp280-core.c:1000 bmp380_chip_config() warn:
> should this be a bitwise op?
> 
> vim +1000 drivers/iio/pressure/bmp280-core.c
> 
> 56e3f8aecddacd Angel Iglesias 2022-06-25   988          if (ret < 0)
> {
> 56e3f8aecddacd Angel Iglesias 2022-06-25  
> 989                  dev_err(data->dev, "failed to write config
> register\n");
> 56e3f8aecddacd Angel Iglesias 2022-06-25  
> 990                  return ret;
> 56e3f8aecddacd Angel Iglesias 2022-06-25   991          }
> 56e3f8aecddacd Angel Iglesias 2022-06-25   992  
> 56e3f8aecddacd Angel Iglesias 2022-06-25   993          /* check
> config error flag */
> 56e3f8aecddacd Angel Iglesias 2022-06-25   994          ret =
> regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
> 56e3f8aecddacd Angel Iglesias 2022-06-25   995          if (ret < 0)
> {
> 56e3f8aecddacd Angel Iglesias 2022-06-25  
> 996                  dev_err(data->dev,
> 56e3f8aecddacd Angel Iglesias 2022-06-25  
> 997                          "failed to read error register\n");
> 56e3f8aecddacd Angel Iglesias 2022-06-25  
> 998                  return ret;
> 56e3f8aecddacd Angel Iglesias 2022-06-25   999          }
> 56e3f8aecddacd Angel Iglesias 2022-06-25 @1000          if (tmp &&
> BMP380_ERR_CONF_MASK) {
>                                                                
> ^^^^^^^^^^^^^^^^^^^^^^^
> Looks like & BMP380_ERR_CONF_MASK was intended.
> 
> 56e3f8aecddacd Angel Iglesias 2022-06-25 
> 1001                  dev_warn(data->dev,
> 56e3f8aecddacd Angel Iglesias 2022-06-25 
> 1002                           "sensor flagged configuration as
> incompatible\n");
> 56e3f8aecddacd Angel Iglesias 2022-06-25  1003                  ret =
> -EINVAL;
> 56e3f8aecddacd Angel Iglesias 2022-06-25  1004          }
> 56e3f8aecddacd Angel Iglesias 2022-06-25  1005  
> 56e3f8aecddacd Angel Iglesias 2022-06-25  1006          return ret;
> 56e3f8aecddacd Angel Iglesias 2022-06-25  1007  }
> 
Thanks! that is an awkward mistake, my bad!
