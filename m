Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D947FD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhL0NBJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Dec 2021 08:01:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13328 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhL0NBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:01:08 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BRAnv43002672;
        Mon, 27 Dec 2021 08:00:46 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3d7c2er6s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 08:00:45 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1BRD0i4q025501
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Dec 2021 08:00:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Dec
 2021 08:00:43 -0500
Received: from ASHBMBX9.ad.analog.com ([fe80::5d54:bde3:ae3a:70bb]) by
 ASHBMBX9.ad.analog.com ([fe80::5d54:bde3:ae3a:70bb%20]) with mapi id
 15.02.0986.014; Mon, 27 Dec 2021 08:00:43 -0500
From:   "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Thread-Topic: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Thread-Index: AQHX8zuqd9YdpCGqgUuEly5L6vKFLqxAZ8IAgAXpymA=
Date:   Mon, 27 Dec 2021 13:00:42 +0000
Message-ID: <edb634a17ba04f4cb5e77fa3b5c69358@analog.com>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
        <20211217114548.1659721-3-cosmin.tanislav@analog.com>
 <20211223130100.059231d6@jic23-huawei>
In-Reply-To: <20211223130100.059231d6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3RhbmlzbGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1mZTE4NWViYS02NzE0LTExZWMtYjZkMC00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcZmUxODVlYmMtNjcxNC0xMWVjLWI2ZDAtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIxNzYxMCIgdD0iMTMyODUwODM2NDEx?=
 =?us-ascii?Q?ODc5NDk2IiBoPSJVTVkwUnd4VUxvOUxOS1hHWlNtaWZIckFYNFE9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUJJa0hIQUlmdlhBUWNuSWtPWHRhdEZCeWNpUTVlMXEwVURBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
x-originating-ip: [10.32.224.39]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: M8aVZsvJbGnALmpBZT8BWq3Ic1mH0g5J
X-Proofpoint-ORIG-GUID: M8aVZsvJbGnALmpBZT8BWq3Ic1mH0g5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_04,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, December 23, 2021 3:02 PM
> To: Cosmin Tanislav <demonsingur@gmail.com>
> Cc: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh+dt@kernel.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
> 
> [External]
> 
> On Fri, 17 Dec 2021 13:45:48 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> > The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> >
> > The ADXL367 does not alias input signals to achieve ultralow power
> > consumption, it samples the full bandwidth of the sensor at all
> > data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> > with a resolution of 0.25mg/LSB on the +-2 g range.
> >
> > In addition to its ultralow power consumption, the ADXL367
> > has many features to enable true system level power reduction.
> > It includes a deep multimode output FIFO, a built-in micropower
> > temperature sensor, and an internal ADC for synchronous conversion
> > of an additional analog input.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> A few comments and questions inline.
> 
> Would definitely be helpful if the datasheet becomes available though
> as would have saved some of the questions.
> 
> Thanks,
> 
> Jonathan

I asked people internally about the possibility of sharing the datasheet publicly,
but until after New Year we probably won't get a response.

> 
> 
> 
> > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > new file mode 100644
> > index 000000000000..ce574f0446eb
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl367.c
> 
> ...
> 
> > +
> > +static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
> > +{
> > +	unsigned int ev_dir;
> > +
> > +	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
> > +		ev_dir = IIO_EV_DIR_RISING;
> > +	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
> > +		ev_dir = IIO_EV_DIR_FALLING;
> > +	else
> > +		return false;
> > +
> > +	iio_push_event(indio_dev,
> > +		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> IIO_MOD_X_OR_Y_OR_Z,
> > +					  IIO_EV_TYPE_THRESH, ev_dir),
> This is unusual for event detection as it's a simple or of separately
> applied thresholds on X, Y and Z axes.  Given the effect of gravity that
> means you have to set the thresholds very wide.
> 
> Also, I'd expect these to be magnitudes, not THRESH - no data sheet that
> I can find though so can't be sure.
> 

Actually, the chip has a referenced, and an absolute mode. We use reference mode
in this driver, as configured in write_event_config.
The motion detection details are about the same as ADXL362 (page 14).
https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL362.pdf


> > +		       iio_get_time_ns(indio_dev));
> > +
> > +	return true;
> > +}
> > +
> > +static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
> > +				   u16 fifo_entries)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +	int i;
> > +
> > +	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
> > +		return false;
> > +
> > +	fifo_entries -= fifo_entries % st->fifo_set_size;
> > +
> > +	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);
> > +	if (ret)
> > +		return false;
> 
> Odd corner cases - it doesn't mean IRQ_NONE is appropriate I think...
> Definitely print an error message if you hit this one but I think you should
> still be returning that IRQ_HANDLED from the caller to avoid getting stuck.
> IRQ_NONE doesn't mean error, it means a spurious IRQ.
> 
> > +
> > +	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> > +		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > +
> > +	return true;
> > +}
> 
> 
> > +
> > +static int adxl367_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long info)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		return adxl367_read_sample(indio_dev, chan, val);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->type) {
> > +		case IIO_ACCEL:
> > +			mutex_lock(&st->lock);
> > +			*val = adxl367_range_scale_tbl[st->range][0];
> > +			*val2 = adxl367_range_scale_tbl[st->range][1];
> > +			mutex_unlock(&st->lock);
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		case IIO_TEMP:
> > +			*val = 1;
> > +			*val2 = ADXL367_TEMP_PER_C;
> > +			return IIO_VAL_FRACTIONAL;
> 
> Base units of temp channels are milli degrees C. Given naming here, this
> looks
> like it might be the scale factor to degrees C.
> Always check Documentation/ABI/testing/sysfs-bus-iio.
> Unfortunately for historical reasons some of the units are not
> entirely obvious.
> 
> > +		case IIO_VOLTAGE:
> > +			*val = ADXL367_VOLTAGE_MAX_MV;
> > +			*val2 = ADXL367_VOLTAGE_MAX_RAW;
> > +			return IIO_VAL_FRACTIONAL;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		switch (chan->type) {
> > +		case IIO_TEMP:
> > +			*val = 25 * ADXL367_TEMP_PER_C -
> ADXL367_TEMP_25C;
> > +			return IIO_VAL_INT;
> > +		case IIO_VOLTAGE:
> > +			*val = ADXL367_VOLTAGE_OFFSET;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		mutex_lock(&st->lock);
> > +		*val = adxl367_samp_freq_tbl[st->odr][0];
> > +		*val2 = adxl367_samp_freq_tbl[st->odr][1];
> > +		mutex_unlock(&st->lock);
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> ...
> 
> > +static int adxl367_read_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +	bool en;
> > +	int ret;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		ret = adxl367_get_act_interrupt_en(st, ADXL367_ACTIVITY,
> &en);
> > +		return ret ?: en;
> > +	case IIO_EV_DIR_FALLING:
> > +		ret = adxl367_get_act_interrupt_en(st,
> ADXL367_INACTIVITY, &en);
> > +		return ret ?: en;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adxl367_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir,
> > +				      int state)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +	enum adxl367_activity_type act;
> > +	int ret;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		act = ADXL367_ACTIVITY;
> > +		break;
> > +	case IIO_EV_DIR_FALLING:
> > +		act = ADXL367_INACTIVITY;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> 
> It's unusual (though not unheard of) to have events that cannot be enabled
> at the same time as a fifo.  If that's true here, please add some comments
> to explain why.  Or is this just about the impact of having to disable
> the measurement to turn it on and the resulting interruption of data
> capture?
> 
> If so that needs more thought as we have a situation where you can (I think)
> have events as long as you enable them before the fifo based capture is
> started,
> but cannot enable them after.
> 

That is indeed the case. You mentioned in a previous patchset that various
attributes could toggle measurement mode while the FIFO capture was running,
so I checked all the possible places where that could happen and added claim
direct mode. Not too nice, but it's the nature of the chip...

> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	ret = adxl367_set_measure_en(st, false);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_act_interrupt_en(st, act, state);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_act_en(st, act, state ?
> ADCL367_ACT_REF_ENABLED
> > +						: ADXL367_ACT_DISABLED);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_measure_en(st, true);
> > +
> > +out:
> > +	mutex_unlock(&st->lock);
> > +
> > +	iio_device_release_direct_mode(indio_dev);
> > +
> > +	return ret;
> > +}
> > +
> 
> > +
> > +static ssize_t adxl367_get_fifo_watermark(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> Trivial but in cases where you don't need the indio_dev, it
> is find to roll the above two lines into one as the function names
> express the types so no information is lost.
> 
> struct adxl367_state *st = iio_priv(dev_to_iio_dev(dev));
> 
> > +	unsigned int fifo_watermark;
> > +
> > +	mutex_lock(&st->lock);
> > +	fifo_watermark = st->fifo_watermark;
> > +	mutex_unlock(&st->lock);
> > +
> > +	return sysfs_emit(buf, "%d\n", fifo_watermark);
> > +}
> ...
> > +
> > +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> > +static IIO_CONST_ATTR(hwfifo_watermark_max,
> > +		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
> > +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> > +		       adxl367_get_fifo_watermark, NULL, 0);
> > +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> > +		       adxl367_get_fifo_enabled, NULL, 0);
> > +
> > +static const struct attribute *adxl367_fifo_attributes[] = {
> > +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> > +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> > +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> > +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> > +	NULL,
> > +};
> 
> ...
> 
> > +static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
> > +				    const unsigned long *active_scan_mask)
> > +{
> > +	struct adxl367_state *st  = iio_priv(indio_dev);
> > +	enum adxl367_fifo_format fifo_format;
> > +	unsigned int fifo_set_size;
> > +	int ret;
> > +
> > +	if (!adxl367_find_mask_fifo_format(active_scan_mask,
> &fifo_format))
> > +		return -EINVAL;
> > +
> > +	fifo_set_size = bitmap_weight(active_scan_mask, indio_dev-
> >masklength);
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	ret = adxl367_set_measure_en(st, false);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_format(st, fifo_format);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_set_size(st, fifo_set_size);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_measure_en(st, true);
> > +
> > +out:
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adxl367_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct adxl367_state *st  = iio_priv(indio_dev);
> > +
> > +	return adxl367_set_temp_adc_mask_en(st, indio_dev-
> >active_scan_mask,
> > +					    true);
> 
> Why the logical separation of the channel enable to here and fifo setup to
> post_enable?  Reality is there is very little reason any more to have
> separate preenable/posteenable.  If there is a reason to do it here, please
> add a comment to explain.
> Is it because this needs to occur before update_scan_mode() is called?
> 
> 

No particular reason, as far as I can remember. I think I was tired at the time.

> > +}
> > +
> > +static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	ret = adxl367_set_measure_en(st, false);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_watermark_interrupt_en(st, true);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_STREAM);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_measure_en(st, true);
> > +
> > +out:
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	ret = adxl367_set_measure_en(st, false);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_DISABLED);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_fifo_watermark_interrupt_en(st, false);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = adxl367_set_measure_en(st, true);
> > +
> > +out:
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adxl367_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct adxl367_state *st = iio_priv(indio_dev);
> > +
> > +	return adxl367_set_temp_adc_mask_en(st, indio_dev-
> >active_scan_mask,
> > +					    false);
> > +}
> > +
> 
> ...
> 
> 
> > +static int adxl367_setup(struct adxl367_state *st)
> > +{
> > +	int ret;
> > +
> > +	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> > +					 ADXL367_2G_RANGE_1G);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> > +					 ADXL367_2G_RANGE_100MG);
> 
> Should one of this pair be inactivity?
> 

Indeed. I must have replaced the correct variant somewhere along the line.

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adxl367_set_act_proc_mode(st, ADXL367_LOOPED);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = _adxl367_set_odr(st, ADXL367_ODR_400HZ);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = _adxl367_set_act_time_ms(st, 10);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = _adxl367_set_inact_time_ms(st, 10000);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return adxl367_set_measure_en(st, true);
> > +}
> > +
> > +static void adxl367_disable_regulators(void *data)
> > +{
> > +	struct adxl367_state *st = data;
> > +
> > +	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> > +}
> > +
> > +int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
> > +		  void *context, struct regmap *regmap, int irq)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adxl367_state *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->dev = dev;
> > +	st->regmap = regmap;
> > +	st->context = context;
> > +	st->ops = ops;
> > +
> > +	mutex_init(&st->lock);
> > +
> > +	indio_dev->channels = adxl367_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
> > +	indio_dev->available_scan_masks = adxl367_channel_masks;
> > +	indio_dev->name = "adxl367";
> > +	indio_dev->info = &adxl367_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	st->regulators[0].supply = "vdd";
> > +	st->regulators[1].supply = "vddio";
> > +
> > +	ret = devm_regulator_bulk_get(st->dev, ARRAY_SIZE(st-
> >regulators),
> > +				      st->regulators);
> > +	if (ret)
> > +		return dev_err_probe(st->dev, ret,
> > +				     "Failed to get regulators\n");
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st-
> >regulators);
> > +	if (ret)
> > +		return dev_err_probe(st->dev, ret,
> > +				     "Failed to enable regulators\n");
> > +
> > +	ret = devm_add_action_or_reset(st->dev,
> adxl367_disable_regulators, st);
> > +	if (ret)
> > +		return dev_err_probe(st->dev, ret,
> > +				     "Failed to add regulators disable
> action\n");
> > +
> > +	ret = adxl367_verify_devid(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adxl367_reset(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adxl367_setup(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> > +					      INDIO_BUFFER_SOFTWARE,
> > +					      &adxl367_buffer_ops,
> > +					      adxl367_fifo_attributes);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_request_threaded_irq(st->dev, irq, NULL,
> > +					adxl367_irq_handler,
> IRQF_ONESHOT,
> > +					indio_dev->name, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(st->dev, ret, "Failed to request
> irq\n");
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(adxl367_probe);
> 
> Something Andy raised in a recent review was that for cases like this
> we should be using the NS variants so that we move stuff used only between
> a smalls set of drivers into it's own namespace.
> 
> I think it is an excellent idea, and will hopefully convert a few drivers
> over shortly.  In the meantime it would be good to ensure no new drivers
> go in without using the NS support
> (EXPORT_SYMBOL_NS_GPL(adxl367_probe, adxl367) etc.
> 

I'll do it for the next patchset.

> > +
> > +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer
> driver");
> > +MODULE_LICENSE("GPL");
