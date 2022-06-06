Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92A153E856
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiFFQJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiFFQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:09:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129AE017
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:09:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so29886580ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tVPhGefm+GvsJF6VgftBj2NdA4gUHa6vMtmIepFS2o=;
        b=WGV6noLQbRHM/I01wzfdtWjPJ9faaOT+sothneiZ8NuNoZsPYgS2KruiQX/h+7dbN2
         yQrIj0ymPvB3PESxQ+mXf4DAfXkjKb+E/5O+K1/xy03sjcSWu/qi/sQlR5ek/URoIIQV
         WIeGzE6G1VpXPrj+kxljBrWIH3v6p2gtYdWywolhbln6f5TBURKWwfL6jgUgKe0iKnNn
         89/mhijZRNwsdbOcUCKz/pY4Hcr7l9mxZPOTBgy9CvjyYth4SkUwWQ/fZhqdvhp7XyVD
         qiI7oTQJyEA9yDBaz5+qvFdrmev++B1dUCijJc/3Pq47AEmx7Je60eGBelgSmrzCPUxM
         DZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tVPhGefm+GvsJF6VgftBj2NdA4gUHa6vMtmIepFS2o=;
        b=INT0u2r9CbPVX628a950rXQJuSknbYAsPkUK5gTfnjzVX+s29ociOG9yU9skQdhhGZ
         reLtDvEIqN7PpWlCNCBwNwKk0YaYhSRqEGiBElglsW7pz0aGox5n6Y5Tft4elnAF1k+N
         +svAJOPZkj8VHnCP/MfX7jfwKJVzCSvjtLICOtWFfxGAS0YDmM1FfD+QunPLsK1JY1kM
         UFiW7rE46MJ2ymGQ6zRyyD8D9DdaA1DSMX0VtMoqmHO6/KvtV1OV1gE9eOBWh1oXD1jZ
         jJVwAtd5AJJE1ZoKRLiVjPLMWGw+qcvMWmlwsNJG1AKYDnPKEcZq7EyJKo5cz3xuFPmB
         9WhQ==
X-Gm-Message-State: AOAM533Rg8BLcI4+05jzqYDUckBDjEIXCjZxL0/UEYHqbuT6AGxYZTw5
        W1oJILWwudMNK74X3We0/fhlQlL0FfUcOkrPsSZyOw==
X-Google-Smtp-Source: ABdhPJx+ALLTlqkGHIng2svvGDKMpNb8lWcNpuUwdkFkqhr5t4SpN8viFBuWmo2q8P8fJjTKklvcDsEauegahdrT0K0=
X-Received: by 2002:a17:907:8689:b0:6fe:e525:ea9c with SMTP id
 qa9-20020a170907868900b006fee525ea9cmr22371754ejc.720.1654531776519; Mon, 06
 Jun 2022 09:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-11-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-11-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 09:09:25 -0700
Message-ID: <CABXOdTdPwvcS2eSrXsT8dNd1XnGNugD6ub-x2qscT8YRwwK0SQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] platform/chrome: cros_ec_proto: arrange get_host_command_version_mask()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> - cros_ec_get_host_command_version_mask() is a private (static) function.
>   Rename it to get_host_command_version_mask().

Personally I prefer to still have prefixes, even for static functions.
If the idea is to have a shorter function name, maybe shorten the rest
of the function name a bit.

Guenter

>
> - Join multiple lines into one if it can fit in 100 columns.
>
> - Don't show MKBP support version if it doesn't support.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c      | 26 ++++++----------
>  drivers/platform/chrome/cros_ec_proto_test.c | 32 ++++++++++----------
>  2 files changed, 25 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 5f4414f05d66..07b57ea105b6 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -400,7 +400,7 @@ static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
>  }
>
>  /*
> - * cros_ec_get_host_command_version_mask
> + * get_host_command_version_mask
>   *
>   * Get the version mask of a given command.
>   *
> @@ -415,16 +415,14 @@ static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
>   * the caller has ec_dev->lock mutex or the caller knows there is
>   * no other command in progress.
>   */
> -static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> -       u16 cmd, u32 *mask)
> +static int get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd, u32 *mask)
>  {
>         struct ec_params_get_cmd_versions *pver;
>         struct ec_response_get_cmd_versions *rver;
>         struct cros_ec_command *msg;
>         int ret;
>
> -       msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
> -                     GFP_KERNEL);
> +       msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)), GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -443,7 +441,6 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>         }
>
>         kfree(msg);
> -
>         return ret;
>  }
>
> @@ -488,21 +485,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                 return -ENOMEM;
>
>         /* Probe if MKBP event is supported */
> -       ret = cros_ec_get_host_command_version_mask(ec_dev,
> -                                                   EC_CMD_GET_NEXT_EVENT,
> -                                                   &ver_mask);
> -       if (ret < 0 || ver_mask == 0)
> +       ret = get_host_command_version_mask(ec_dev, EC_CMD_GET_NEXT_EVENT, &ver_mask);
> +       if (ret < 0 || ver_mask == 0) {
>                 ec_dev->mkbp_event_supported = 0;
> -       else
> +       } else {
>                 ec_dev->mkbp_event_supported = fls(ver_mask);
> -
> -       dev_dbg(ec_dev->dev, "MKBP support version %u\n",
> -               ec_dev->mkbp_event_supported - 1);
> +               dev_dbg(ec_dev->dev, "MKBP support version %u\n", ec_dev->mkbp_event_supported - 1);
> +       }
>
>         /* Probe if host sleep v1 is supported for S0ix failure detection. */
> -       ret = cros_ec_get_host_command_version_mask(ec_dev,
> -                                                   EC_CMD_HOST_SLEEP_EVENT,
> -                                                   &ver_mask);
> +       ret = get_host_command_version_mask(ec_dev, EC_CMD_HOST_SLEEP_EVENT, &ver_mask);
>         ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
>
>         /* Get host event wake mask. */
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 22f9322787f4..e2c369765612 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -217,7 +217,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 data->max_request_packet_size = 0xbf;
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 struct ec_response_get_cmd_versions *data;
>
> @@ -228,7 +228,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 data->version_mask = BIT(6) | BIT(5);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 struct ec_response_get_cmd_versions *data;
>
> @@ -288,7 +288,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, ec_dev->max_passthru, 0xbf - sizeof(struct ec_host_request));
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 struct ec_params_get_cmd_versions *data;
>
> @@ -307,7 +307,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, ec_dev->mkbp_event_supported, 7);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 struct ec_params_get_cmd_versions *data;
>
> @@ -502,7 +502,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 struct ec_response_get_cmd_versions *data;
>
> @@ -543,7 +543,7 @@ static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 struct ec_params_get_cmd_versions *data;
>
> @@ -596,7 +596,7 @@ static void cros_ec_proto_test_query_all_no_mkbp2(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_add(test, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -632,7 +632,7 @@ static void cros_ec_proto_test_query_all_no_mkbp2(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 struct ec_params_get_cmd_versions *data;
>
> @@ -685,14 +685,14 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_add(test,
>                                                    sizeof(struct ec_response_get_cmd_versions));
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 struct ec_response_get_cmd_versions *data;
>
> @@ -733,7 +733,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -745,7 +745,7 @@ static void cros_ec_proto_test_query_all_no_host_sleep(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -793,14 +793,14 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_add(test,
>                                                    sizeof(struct ec_response_get_cmd_versions));
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_add(test,
>                                                    sizeof(struct ec_response_get_cmd_versions));
> @@ -844,7 +844,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       /* For get_host_command_version_mask() for MKBP. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -856,7 +856,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
>         }
>
> -       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       /* For get_host_command_version_mask() for host sleep v1. */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> --
> 2.36.1.255.ge46751e96f-goog
>
