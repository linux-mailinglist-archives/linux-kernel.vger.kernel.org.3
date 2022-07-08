Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875756C3AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbiGHVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiGHVvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:51:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7D9B1BE;
        Fri,  8 Jul 2022 14:51:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e16so149944pfm.11;
        Fri, 08 Jul 2022 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiNv0Alai9EH7dZDCi1PyHKKwG3IbGXbZWz3fQBsea8=;
        b=MSz4Sm3eITqXDffTpexNgFQFo7gFIvmPs3JBn/F3fpFocDwbkg+WMkcfNId1grcwDG
         XkQTIF4u6HzejKTwBGiZMndZt7BKxB3EvqqHTtc1tZtuD7nQpqHfz5LvG9h0wbKJXqtJ
         IyeMFo7h29QSXPSQbs2AwS0Ca//VgT7ATmPQx4ibHMKh+I5pGCd8NU9kWuV/qZzmQeHA
         U8EptU0ZICnSwyv4n5DwO1iBLnAUjJw8vANMr5ESSPQhXu2W/uNvRYfU6SeiDJNhTW8W
         ABUVnBrvOVMmDE7vDUXktoKQ9tYBy2Q9LwuXdVd6aCsMsL+bkeMeABQvqDElBTiN82RV
         JcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiNv0Alai9EH7dZDCi1PyHKKwG3IbGXbZWz3fQBsea8=;
        b=jAG3OXTOgNqCDg6/CBoQLuMJq0L0uynX1xMKI/NOxqGnj54eXjADbIDBCU/4fQeZOx
         XlvB3+7ZMnLhYbchy+LTCm5XTqOUbcDaN+Gy7XnSYu9ffm1yJLeR0pRC16rCRhOLrMUG
         76MrAR7OIzIZB6vTsnsQbVPrKKMmoY31XPJcZk077fZCQxlqMPVW2nlBVtsaIYYuyIQW
         yZ3qrhQDGbRud1PTzQdiRancMkUnEg8FOehI4Ksop2MFPVKFDIHvSdzeXDbJ+uqzKh7G
         TUDxFikbzTsdZ3OrEaVvS5PUMOW+UnFS5ybV7nMooPxd+/R4OdCuBsRIUS1ZbCsv8ufG
         gV7Q==
X-Gm-Message-State: AJIora/Qo97YHlIVDVFqmFeUAxkkxTufpZT+77gca+kCooIecx+Y8pCC
        kv0crbUB8EdJKMocK/bVrQ8=
X-Google-Smtp-Source: AGRyM1uYhqCsDi8OmJDblGFpyMNCU0JzLEh/Ftbo6SVxxodcocclwAq3ghkXUpOOn8qg0rjTEYq0qg==
X-Received: by 2002:a63:87c8:0:b0:415:b0c1:56f5 with SMTP id i191-20020a6387c8000000b00415b0c156f5mr5165733pge.352.1657317105874;
        Fri, 08 Jul 2022 14:51:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9707:b37:49b0:77c2])
        by smtp.gmail.com with ESMTPSA id lk5-20020a17090b33c500b001ef92e0e7c1sm2137246pjb.10.2022.07.08.14.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:51:44 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:51:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] Input: mtk-pmic-keys - Add support for MT6331
 PMIC keys
Message-ID: <Ysim7S2xjkbCFDJ1@google.com>
References: <20220706101122.201007-1-angelogioacchino.delregno@collabora.com>
 <202207061915.tYTQKEhu-lkp@intel.com>
 <4e55465d-ccf1-56b0-dfa4-84832edfa937@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e55465d-ccf1-56b0-dfa4-84832edfa937@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:13:45PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/07/22 13:44, kernel test robot ha scritto:
> > Hi AngeloGioacchino,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on dtor-input/next]
> > [also build test ERROR on linus/master v5.19-rc5 next-20220705]
> 
> 
> This patch compiles fine on next-20220706.

Unfortunately linux/mfd/mt6331/registers.h is still not in mainline. We
either need to wait when it gets there or ask Lee for an immutable
branch that would contain shared definitions that I cam pull from.

Thanks.

-- 
Dmitry
