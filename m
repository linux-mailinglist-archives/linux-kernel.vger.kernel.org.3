Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B654CDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347672AbiFOP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiFOP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:56:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9EC34B81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:56:44 -0700 (PDT)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkYoK-1nI2sO1lOg-00m0OG for <linux-kernel@vger.kernel.org>; Wed, 15 Jun
 2022 17:56:42 +0200
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31756c8143aso17311617b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:56:42 -0700 (PDT)
X-Gm-Message-State: AJIora+W3CDHVMMXxqsra0Vu+5n4VYBBtAfs3XEJ20pr0kQdu9KS3ClW
        xLBVou2mKrBkEXj93gNRCFP4eUDnXJCDms7HWOE=
X-Google-Smtp-Source: AGRyM1ssQ7EkBm0qhH6uDU4lXFFKkY053t2zRQKkm7NkkX1tRS8R0U8rR1KSzLg2YqYKcIWowFkLquLpJFSuHzvzLzY=
X-Received: by 2002:a81:6ac5:0:b0:317:5299:523d with SMTP id
 f188-20020a816ac5000000b003175299523dmr334950ywc.249.1655308601292; Wed, 15
 Jun 2022 08:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <202206091828.eNkyL2EI-lkp@intel.com> <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
 <20220615085128.026f1c56@kernel.org>
In-Reply-To: <20220615085128.026f1c56@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 17:56:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1s-jKfDFo7CXjpM4B6JJS-bV901yCfOxr9qikV7AO_LQ@mail.gmail.com>
Message-ID: <CAK8P3a1s-jKfDFo7CXjpM4B6JJS-bV901yCfOxr9qikV7AO_LQ@mail.gmail.com>
Subject: Re: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error:
 enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data'
 is not an integer constant
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kibgdac5anD311UKLzVwawKGStg/O1L1WqjsURAv0Kej2dD04R3
 f+7XCuZ7zfTwQuLuNFm6/IFpTSHlScZkWZ/HrI2mjF/hO7i3pifhW+3lU/xzKss782MGaU2
 5QAK9pmIP+RjUbKrM17epI3BDzU3qjgMZ/MbCMMVtp7h+Aj6d+kj6laWpBLaUz7PnCcvXCE
 D0gfe0Z7nVyTbKctpOzZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQ+FoMG01EI=:6bw3+YgciNdxOoeWfmcZ1N
 QwLA4idEN59mywVVcLuTMKN6qeJAfOgLAs2eWfLah2qIPlTu5Ahs2k6wLQrLZPeiBQZJZ/Ta3
 UkgykGKEm6bq9u2yRICm+dB15o1KUfAb9zg5BskcdiNS7htYGhr6/TwQL+T0Aen77tG4wdjgL
 ZvzxPbvslfHj5OoXVOnBrRmNQebg1VKHZwIzgSqL5eNTXYfrjx19CIsmDr53r9QzjDevmiMib
 wcnVFSmp3pmc+NFXBAi5yst/M8BhFpozYUMZn45l0DvBzaFf0uJYwELJLcpO5/MxsqLkTOoj1
 mBIzhB/tx59h6GOZoJYDzRwaLotROGP0qZ9tlrNvSKpvF/dJqqGDbMeyCu1ulnrNWXX8UC5fS
 Ajz0Izp2fgLZARe3185cuOaT6ORDR7BJJPxrwMJawv0Qsl6WdyPmXVL2ghA2HH9wlF+0YSEYR
 VYZ9UvozcMZDYHuDVWRG8UgenX6kwMWwQis9I9618tr86Gy5k375HxlVFMkJgIi3HB4+rjEmx
 T+QAvPu0F67epoHbKA3eds+98SzreC9WfEHgMAzEZlmLk2tV/uyAEqBfgeX2Y3eA6ego6fmsO
 Wrq71bTwdpWO+rI6sCtKUO0FniC8tK9Jwk8loysTUwPtA4soWWOy4aRe8fxe9bA6Ly8rGRmBv
 /leIN+RPfsHEoChTkUJaMgLqIefhx0ByEhiG9gJ5tgntvg1NqQmcUIJ9Yv07Dwr0zYLsNjz62
 cP7vtsfkzE/FF6KQdBzkM6qZLaxonZHzPUr1r8SspJB7y2Fbtg4wGKPV87uNOBTaBDQ9cz1dU
 ysrC7fTJVsQWlevw7AwWMMVkaWHKJz5xmvxM0hNXAeQOyx+HRvJ3/6UwBzHQVfbtxhC4csyWE
 2qiMvzLtaobhlgheLPGGvU6SXgPWdO8ndD3ArBj+M=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 5:51 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 15 Jun 2022 16:11:17 +0200 Arnd Bergmann wrote:
> > The bug is that 'i40e_aqc_cloud_filters_element_data' and some other
> > structures in the
> > same file are broken when building an ARM kernel without CONFIG_AEABI, which has
> > unusual struct packing rules and triggers the static assertion.
>
> What are those packing rules, out of curiosity?

On the old OABI, each struct member is on a 32-bit boundary.

       Arnd
