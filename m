Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695135425C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiFHBXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384018AbiFGVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:53:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1F248517
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:12:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c2so24209284edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kb1j+lCYcgNJfFRtU39ymeKe9zS4sLF08OKHSZXXsk=;
        b=adPlAQ+Bou+4Tln1nEnCl84skioMttrUky89A5FguxVn/QEfz2lsfXdaCoPuhegnEx
         pS2Mf4tzCXPnX6a8rBGJKlMDM4JWozBITUs7OtqwUZXEauNgL5wFDann1NuPVQ84R2/F
         SiKHKY/gcUNMiz6keZBbt5ej+HUZZW5D+bWpceuKEd21chp/ec4OWlKCOgWNh1ocs1XD
         ETkKWwHNDT9V6uFbdvIvo0/d8cHwH5vy4OFxVGp9kdPjouw0Eq3beVkPpg8w3PZMIO0j
         xNO2/Pob0Fhg/JiNAyl3k26tOS79XwzGqBJJsCCYQ34+SEOad5CzgNlrl/gb7rCYYC4d
         pG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kb1j+lCYcgNJfFRtU39ymeKe9zS4sLF08OKHSZXXsk=;
        b=c1dM7/vTDKoWZKTxxfqMNxcpGRVXIlYzJ17OUTt06RCTl/+2jgvCfiIsF2ny7gUxLn
         GJKmZP+aY3bhT2jU7oG8gf+7eDzuPlZgKgU75rbNP/ZQYwqGXhVmIxLIVtZVY11ZmBC+
         VGCB3w4fe93BWMU9icMOgHBcS523m/eJftEAmuUMFbmeKnX3eGGV3cEGOWugLpXGR5Jw
         tYtGpVzARuqtomS41dZnDkF36ivvflZImbmKLR9xR1JYwCA9X11DzRD7ZsY4jLg/x9xD
         tVB/LAjRLjB+2fPbssFSRMZADlz3VtY/2+y0nYqzzR8vhsxeZF0lCEqTn3eLQXE82tKl
         ZMfA==
X-Gm-Message-State: AOAM530PA+8y+vcTzwXf9sPiSGQt0NvVuMsmVBq4qOk28kQM8Z4XJaca
        P/tOHyf8S+df3ldwX4cPhkeoF5s7Bp7SwRMupeO2+Q==
X-Google-Smtp-Source: ABdhPJzDz+gUGeg7JrjZDYQJqx4ADRcQHPr104EcjqIGmFojpTe85n7p+Y2kwYAcqviPln3kX1gG0YoHp2ksvNLfBkA=
X-Received: by 2002:a05:6402:2687:b0:430:328f:e46b with SMTP id
 w7-20020a056402268700b00430328fe46bmr22886699edd.33.1654629156511; Tue, 07
 Jun 2022 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220607145639.2362750-1-tzungbi@kernel.org> <20220607145639.2362750-16-tzungbi@kernel.org>
In-Reply-To: <20220607145639.2362750-16-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 12:12:25 -0700
Message-ID: <CABXOdTcYD6L6vnfNJwYROo1ynGqkabdbpm8JjvvosjtYGV1xow@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] platform/chrome: cros_ec_proto: return 0 on
 getting wake mask success
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_get_host_event_wake_mask() used to return value from
> send_command() which is number of bytes for input payload on success
> (i.e. sizeof(struct ec_response_host_event_mask)).
>
> However, the callers don't need to know how many bytes are available.
>
> - Fix cros_ec_get_host_event_wake_mask() to return 0 on success;
>   negative integers on error.
>
> - Add a Kunit test for guarding if send_command() returns 0 in
>   get_host_event_wake_mask().
>
Please split into two patches.

Thanks,
Guenter

> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1:
> - Return 0 on success; otherwise, negative intergers.
>
>  drivers/platform/chrome/cros_ec_proto.c      |  23 ++--
>  drivers/platform/chrome/cros_ec_proto_test.c | 128 +++++++++++++++++++
>  2 files changed, 142 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 9d96ed16244f..04c852aa790b 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -256,18 +256,23 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
>         msg->insize = sizeof(*r);
>
>         ret = send_command(ec_dev, msg);
> -       if (ret >= 0) {
> -               mapped = cros_ec_map_error(msg->result);
> -               if (mapped) {
> -                       ret = mapped;
> -                       goto exit;
> -               }
> +       if (ret < 0)
> +               goto exit;
> +
> +       mapped = cros_ec_map_error(msg->result);
> +       if (mapped) {
> +               ret = mapped;
> +               goto exit;
>         }
> -       if (ret > 0) {
> -               r = (struct ec_response_host_event_mask *)msg->data;
> -               *mask = r->mask;
> +
> +       if (ret == 0) {
> +               ret = -EPROTO;
> +               goto exit;
>         }
>
> +       r = (struct ec_response_host_event_mask *)msg->data;
> +       *mask = r->mask;
> +       ret = 0;
>  exit:
>         kfree(msg);
>         return ret;
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index af69410f2978..3ee0de337d53 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1406,6 +1406,133 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>         }
>  }
>
> +static void cros_ec_proto_test_query_all_default_wake_mask_return0(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +
> +       /* Set some garbage bytes. */
> +       ec_dev->host_event_wake_mask = U32_MAX;
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               struct ec_response_get_protocol_info *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               /*
> +                * Although it doesn't check the value, provides valid sizes so that
> +                * cros_ec_query_all() allocates din and dout correctly.
> +                */
> +               data = (struct ec_response_get_protocol_info *)mock->o_data;
> +               data->max_request_packet_size = 0xbe;
> +               data->max_response_packet_size = 0xef;
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For get_host_event_wake_mask(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       cros_ec_proto_test_query_all_pretest(test);
> +       ret = cros_ec_query_all(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command,
> +                               EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
> +                               EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_cmd_versions));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_cmd_versions));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
> +       }
> +
> +       /* For get_host_event_wake_mask(). */
> +       {
> +               u32 mask;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HOST_EVENT_GET_WAKE_MASK);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_host_event_mask));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +
> +               mask = ec_dev->host_event_wake_mask;
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_CLOSED), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_LOW), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_CRITICAL), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_STATUS), 0);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -1471,6 +1598,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep_return0),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
> +       KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return0),
>         {}
>  };
>
> --
> 2.36.1.255.ge46751e96f-goog
>
