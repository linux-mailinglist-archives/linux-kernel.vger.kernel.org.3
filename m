Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F83756AE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiGGWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiGGWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:06:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B95C967
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:06:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id h132so4168961ybb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UFGapQUmVzze+bPOzX448q4o7gbh7fA6vE58zBhvvM=;
        b=ZP8qKMGpzxTcxHpyX+YtpLCre0I0SLiX8dNkR8f1hwUFCt8K0TvDtqClFnq/w5L0y9
         cOcFu5jmvSQaMMLyPQMZEZytUZO4bCtIFApl70ZnFq5Db+3RXsPhWy0AoUmubKqhZ4So
         bw1yhLs9WWrUn7z2sQ9FUW77rqTD7DgTUYGfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UFGapQUmVzze+bPOzX448q4o7gbh7fA6vE58zBhvvM=;
        b=ryaTJ+xvx2Y2g2DCkxzm1Mkg/UUEiHd2KVNkYIAmZUbPqJK1++bnGEuOQwHjA5zi0q
         uc1hM8bM7vrR7w2aiWBVVM7E5yyqOQTyHK0EF9TYG5eJQ+B2v5RQp9OV1kLQbdNof0rl
         53Rz7A4S+kFFq46B/cEIMcjbzKjR/EuNocygrtafNQD0Q7N7JN0+SEMJuUtgSs3DXu87
         ejMkyDXO6hJi/U8J6It3sXYmv7ph6MidOArkJupDG+wVI0f72l71SSyUagMltefV4ycG
         jd8VbxsN5TH4FP+CG5sxVTnQ+7pj1Mf4vcVNCEc8tubmGMxXXm09kmK/jgp1Dz3ThGyZ
         8anA==
X-Gm-Message-State: AJIora9ZvIjGRwTThq20HJST4hp86er7MvxQSqgq9EcUEwJy1N6AQCAz
        KtFuiJNUydonFZ4JZZBnZPP3kf6TBEb8zT8C9jP+0A==
X-Google-Smtp-Source: AGRyM1tA88lK8bMldivq5Q8tXTohFQGXUUrPduGItjYoy9GpwYyOXFyU3HX0TeVAhcOPU/AITKKPXUEpF+NN+gSsVRg=
X-Received: by 2002:a25:b7cf:0:b0:66e:2ddc:dda7 with SMTP id
 u15-20020a25b7cf000000b0066e2ddcdda7mr88408ybj.197.1657231593901; Thu, 07 Jul
 2022 15:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220706171601.807042-7-pmalani@chromium.org> <202207071256.63ElDHIG-lkp@intel.com>
In-Reply-To: <202207071256.63ElDHIG-lkp@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 7 Jul 2022 15:06:23 -0700
Message-ID: <CACeCKadwM7VVZadZxDr-TQ0DB1Dy5mv2bwY=p+p3Y1uVNHE8Tg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] platform/chrome: cros_typec_switch: Add event check
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, kbuild-all@lists.01.org,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 9:26 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Prashant,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on usb/usb-testing]
> [cannot apply to chrome-platform/for-next linus/master balbi-usb/testing/next peter-chen-usb/for-usb-next v5.19-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Prashant-Malani/platform-chrome-Type-C-switch-driver-and-Type-C-framework-updates/20220707-012614
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220707/202207071256.63ElDHIG-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/60e03c1b36c0e3533e481b44152faab38448be5b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Prashant-Malani/platform-chrome-Type-C-switch-driver-and-Type-C-framework-updates/20220707-012614
>         git checkout 60e03c1b36c0e3533e481b44152faab38448be5b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/chrome/ kernel/bpf/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/platform/chrome/cros_typec_switch.c:81:6: warning: no previous prototype for 'cros_typec_check_event' [-Wmissing-prototypes]
>       81 | bool cros_typec_check_event(struct cros_typec_switch_data *sdata, int port_num, u32 mask)
>          |      ^~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/chrome/cros_typec_switch.c:159:6: warning: no previous prototype for 'cros_typec_unregister_switches' [-Wmissing-prototypes]
>      159 | void cros_typec_unregister_switches(struct cros_typec_switch_data *sdata)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/platform/chrome/cros_typec_switch.c:170:5: warning: no previous prototype for 'cros_typec_register_retimer' [-Wmissing-prototypes]
>      170 | int cros_typec_register_retimer(struct cros_typec_port *port, struct fwnode_handle *fwnode)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
I'll fix these warnings and send out a v3.
Apologies for the churn.

-Prashant
